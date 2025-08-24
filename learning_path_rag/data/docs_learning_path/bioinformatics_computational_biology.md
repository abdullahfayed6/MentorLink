# Bioinformatics & Computational Biology

## Table of Contents
- [Introduction](#introduction)
- [Sequence Analysis](#sequence-analysis)
- [Genomic Data Analysis](#genomic-data-analysis)
- [Protein Structure Prediction](#protein-structure-prediction)
- [Phylogenetic Analysis](#phylogenetic-analysis)
- [Systems Biology](#systems-biology)
- [Machine Learning in Bioinformatics](#machine-learning-in-bioinformatics)
- [Drug Discovery](#drug-discovery)

## Introduction

Bioinformatics combines biology, computer science, and statistics to analyze and interpret biological data, particularly molecular sequences and structures.

## Sequence Analysis

### DNA Sequence Analysis
```python
from Bio import SeqIO, Seq
from Bio.SeqUtils import GC, molecular_weight
import numpy as np

class DNAAnalyzer:
    def __init__(self, sequence):
        if isinstance(sequence, str):
            self.sequence = Seq.Seq(sequence)
        else:
            self.sequence = sequence
    
    def basic_stats(self):
        """Calculate basic sequence statistics"""
        seq_str = str(self.sequence)
        return {
            'length': len(seq_str),
            'gc_content': GC(seq_str),
            'molecular_weight': molecular_weight(seq_str, seq_type='DNA'),
            'composition': {
                'A': seq_str.count('A'),
                'T': seq_str.count('T'),
                'G': seq_str.count('G'),
                'C': seq_str.count('C')
            }
        }
    
    def find_orfs(self, min_length=100):
        """Find open reading frames"""
        start_codons = ['ATG']
        stop_codons = ['TAA', 'TAG', 'TGA']
        
        orfs = []
        seq_str = str(self.sequence)
        
        for frame in range(3):
            for strand in [1, -1]:
                if strand == -1:
                    work_seq = seq_str[::-1].translate(str.maketrans('ATCG', 'TAGC'))
                else:
                    work_seq = seq_str
                
                for i in range(frame, len(work_seq) - 2, 3):
                    codon = work_seq[i:i+3]
                    if len(codon) == 3 and codon in start_codons:
                        for j in range(i + 3, len(work_seq) - 2, 3):
                            stop_codon = work_seq[j:j+3]
                            if len(stop_codon) == 3 and stop_codon in stop_codons:
                                orf_length = j - i + 3
                                if orf_length >= min_length:
                                    orfs.append({
                                        'start': i if strand == 1 else len(seq_str) - j - 3,
                                        'end': j + 3 if strand == 1 else len(seq_str) - i,
                                        'strand': strand,
                                        'frame': frame + 1,
                                        'length': orf_length,
                                        'sequence': work_seq[i:j+3]
                                    })
                                break
        
        return orfs

def needleman_wunsch(seq1, seq2, match=2, mismatch=-1, gap=-1):
    """Global sequence alignment using Needleman-Wunsch algorithm"""
    m, n = len(seq1), len(seq2)
    
    # Initialize scoring matrix
    score_matrix = np.zeros((m + 1, n + 1))
    
    # Initialize first row and column
    for i in range(1, m + 1):
        score_matrix[i][0] = score_matrix[i-1][0] + gap
    for j in range(1, n + 1):
        score_matrix[0][j] = score_matrix[0][j-1] + gap
    
    # Fill scoring matrix
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if seq1[i-1] == seq2[j-1]:
                diagonal = score_matrix[i-1][j-1] + match
            else:
                diagonal = score_matrix[i-1][j-1] + mismatch
            
            up = score_matrix[i-1][j] + gap
            left = score_matrix[i][j-1] + gap
            
            score_matrix[i][j] = max(diagonal, up, left)
    
    # Traceback
    align1, align2 = '', ''
    i, j = m, n
    
    while i > 0 or j > 0:
        current_score = score_matrix[i][j]
        
        if i > 0 and j > 0:
            diagonal_score = score_matrix[i-1][j-1]
            if seq1[i-1] == seq2[j-1]:
                diagonal_score += match
            else:
                diagonal_score += mismatch
            
            if current_score == diagonal_score:
                align1 = seq1[i-1] + align1
                align2 = seq2[j-1] + align2
                i -= 1
                j -= 1
                continue
        
        if i > 0 and current_score == score_matrix[i-1][j] + gap:
            align1 = seq1[i-1] + align1
            align2 = '-' + align2
            i -= 1
        elif j > 0 and current_score == score_matrix[i][j-1] + gap:
            align1 = '-' + align1
            align2 = seq2[j-1] + align2
            j -= 1
    
    return align1, align2, score_matrix[m][n]
```

### RNA Secondary Structure Prediction
```python
class RNAFolder:
    def __init__(self):
        # Simplified energy parameters
        self.base_pair_energy = {
            ('A', 'U'): -2.0, ('U', 'A'): -2.0,
            ('G', 'C'): -3.0, ('C', 'G'): -3.0,
            ('G', 'U'): -1.0, ('U', 'G'): -1.0
        }
        self.loop_energy = 3.0
    
    def can_pair(self, base1, base2):
        """Check if two bases can form a pair"""
        return (base1, base2) in self.base_pair_energy
    
    def nussinov_algorithm(self, sequence):
        """RNA secondary structure prediction using Nussinov algorithm"""
        n = len(sequence)
        dp = np.zeros((n, n))
        
        # Fill the DP table
        for length in range(1, n):
            for i in range(n - length):
                j = i + length
                if j - i < 4:  # Minimum loop size
                    continue
                
                # Case 1: j is unpaired
                dp[i][j] = dp[i][j-1]
                
                # Case 2: j pairs with some k
                for k in range(i, j - 3):
                    if self.can_pair(sequence[k], sequence[j]):
                        energy = dp[i][k-1] + dp[k+1][j-1] + 1
                        if k == i:
                            energy = dp[k+1][j-1] + 1
                        dp[i][j] = max(dp[i][j], energy)
        
        # Traceback to get structure
        structure = self.traceback(sequence, dp, 0, n-1)
        return structure, dp[0][n-1]
    
    def traceback(self, sequence, dp, i, j):
        """Traceback to reconstruct secondary structure"""
        if i >= j:
            return '.' * max(0, j - i + 1)
        
        # Check if j is unpaired
        if dp[i][j] == dp[i][j-1]:
            return self.traceback(sequence, dp, i, j-1) + '.'
        
        # Find the pairing partner
        for k in range(i, j - 3):
            if self.can_pair(sequence[k], sequence[j]):
                expected_score = dp[i][k-1] + dp[k+1][j-1] + 1
                if k == i:
                    expected_score = dp[k+1][j-1] + 1
                
                if dp[i][j] == expected_score:
                    left = self.traceback(sequence, dp, i, k-1) if k > i else ''
                    middle = self.traceback(sequence, dp, k+1, j-1)
                    return left + '(' + middle + ')'
        
        return '.' * (j - i + 1)
```

## Genomic Data Analysis

### Variant Calling Pipeline
```python
import pysam
from collections import defaultdict

class VariantCaller:
    def __init__(self, reference_file, bam_file):
        self.reference = pysam.FastaFile(reference_file)
        self.bam = pysam.AlignmentFile(bam_file, "rb")
    
    def call_variants(self, chromosome, start, end, min_depth=10, min_variant_freq=0.2):
        """Simple variant calling based on allele frequency"""
        variants = []
        
        for pos in range(start, end):
            # Get pileup at position
            allele_counts = defaultdict(int)
            total_depth = 0
            
            for pileupcolumn in self.bam.pileup(chromosome, pos, pos + 1):
                if pileupcolumn.pos == pos:
                    for pileupread in pileupcolumn.pileups:
                        if not pileupread.is_del and not pileupread.is_refskip:
                            base = pileupread.alignment.query_sequence[pileupread.query_position]
                            allele_counts[base] += 1
                            total_depth += 1
            
            if total_depth >= min_depth:
                ref_base = self.reference.fetch(chromosome, pos, pos + 1).upper()
                
                for allele, count in allele_counts.items():
                    frequency = count / total_depth
                    
                    if allele != ref_base and frequency >= min_variant_freq:
                        variants.append({
                            'chromosome': chromosome,
                            'position': pos + 1,  # 1-based
                            'reference': ref_base,
                            'alternate': allele,
                            'depth': total_depth,
                            'variant_count': count,
                            'frequency': frequency
                        })
        
        return variants
    
    def annotate_variants(self, variants, gene_annotations):
        """Annotate variants with gene information"""
        annotated_variants = []
        
        for variant in variants:
            annotation = {
                'variant': variant,
                'gene': None,
                'effect': 'intergenic'
            }
            
            # Find overlapping genes
            for gene in gene_annotations:
                if (gene['chromosome'] == variant['chromosome'] and
                    gene['start'] <= variant['position'] <= gene['end']):
                    
                    annotation['gene'] = gene['name']
                    
                    # Determine effect type
                    if gene['type'] == 'exon':
                        annotation['effect'] = 'exonic'
                    elif gene['type'] == 'intron':
                        annotation['effect'] = 'intronic'
                    else:
                        annotation['effect'] = 'genic'
                    break
            
            annotated_variants.append(annotation)
        
        return annotated_variants
```

### Genome Assembly Metrics
```python
class AssemblyAnalyzer:
    def __init__(self, contigs):
        self.contigs = sorted(contigs, key=len, reverse=True)
        self.total_length = sum(len(contig) for contig in contigs)
    
    def calculate_n50(self):
        """Calculate N50 - length where 50% of assembly is in contigs of this size or larger"""
        cumulative_length = 0
        half_length = self.total_length / 2
        
        for contig in self.contigs:
            cumulative_length += len(contig)
            if cumulative_length >= half_length:
                return len(contig)
        
        return 0
    
    def calculate_nx(self, x):
        """Calculate Nx statistic"""
        cumulative_length = 0
        target_length = self.total_length * x / 100
        
        for contig in self.contigs:
            cumulative_length += len(contig)
            if cumulative_length >= target_length:
                return len(contig)
        
        return 0
    
    def assembly_stats(self):
        """Calculate comprehensive assembly statistics"""
        return {
            'total_length': self.total_length,
            'num_contigs': len(self.contigs),
            'largest_contig': len(self.contigs[0]) if self.contigs else 0,
            'n50': self.calculate_n50(),
            'n90': self.calculate_nx(90),
            'gc_content': self.calculate_gc_content(),
            'gaps': self.count_gaps()
        }
    
    def calculate_gc_content(self):
        """Calculate overall GC content"""
        total_gc = sum(contig.count('G') + contig.count('C') for contig in self.contigs)
        return total_gc / self.total_length * 100 if self.total_length > 0 else 0
    
    def count_gaps(self):
        """Count number of N characters (gaps)"""
        return sum(contig.count('N') for contig in self.contigs)
```

## Protein Structure Prediction

### Secondary Structure Prediction
```python
class ProteinStructurePredictor:
    def __init__(self):
        # Chou-Fasman parameters (simplified)
        self.propensities = {
            'A': {'alpha': 1.42, 'beta': 0.83, 'turn': 0.66},
            'R': {'alpha': 0.98, 'beta': 0.93, 'turn': 0.95},
            'N': {'alpha': 0.67, 'beta': 0.89, 'turn': 1.56},
            'D': {'alpha': 1.01, 'beta': 0.54, 'turn': 1.46},
            'C': {'alpha': 0.70, 'beta': 1.19, 'turn': 1.19},
            'Q': {'alpha': 1.11, 'beta': 1.10, 'turn': 0.98},
            'E': {'alpha': 1.51, 'beta': 0.37, 'turn': 0.74},
            'G': {'alpha': 0.57, 'beta': 0.75, 'turn': 1.56},
            'H': {'alpha': 1.00, 'beta': 0.87, 'turn': 0.95},
            'I': {'alpha': 1.08, 'beta': 1.60, 'turn': 0.47},
            'L': {'alpha': 1.21, 'beta': 1.30, 'turn': 0.59},
            'K': {'alpha': 1.16, 'beta': 0.74, 'turn': 1.01},
            'M': {'alpha': 1.45, 'beta': 1.05, 'turn': 0.60},
            'F': {'alpha': 1.13, 'beta': 1.38, 'turn': 0.60},
            'P': {'alpha': 0.57, 'beta': 0.55, 'turn': 1.52},
            'S': {'alpha': 0.77, 'beta': 0.75, 'turn': 1.43},
            'T': {'alpha': 0.83, 'beta': 1.19, 'turn': 0.96},
            'W': {'alpha': 1.08, 'beta': 1.37, 'turn': 0.96},
            'Y': {'alpha': 0.69, 'beta': 1.47, 'turn': 1.14},
            'V': {'alpha': 1.06, 'beta': 1.70, 'turn': 0.50}
        }
    
    def chou_fasman_prediction(self, sequence, window_size=6):
        """Predict secondary structure using Chou-Fasman method"""
        if len(sequence) < window_size:
            return 'C' * len(sequence)
        
        structure = []
        
        for i in range(len(sequence)):
            # Calculate average propensities in window
            start = max(0, i - window_size // 2)
            end = min(len(sequence), i + window_size // 2 + 1)
            
            avg_alpha = sum(self.propensities.get(aa, {'alpha': 1.0})['alpha'] 
                          for aa in sequence[start:end]) / (end - start)
            avg_beta = sum(self.propensities.get(aa, {'beta': 1.0})['beta'] 
                         for aa in sequence[start:end]) / (end - start)
            
            # Assign secondary structure
            if avg_alpha > 1.03 and avg_alpha > avg_beta:
                structure.append('H')  # Alpha helix
            elif avg_beta > 1.05 and avg_beta > avg_alpha:
                structure.append('E')  # Beta sheet
            else:
                structure.append('C')  # Coil
        
        return ''.join(structure)
    
    def calculate_hydrophobicity(self, sequence):
        """Calculate hydrophobicity profile"""
        hydrophobicity_scale = {
            'A': 1.8, 'R': -4.5, 'N': -3.5, 'D': -3.5, 'C': 2.5,
            'Q': -3.5, 'E': -3.5, 'G': -0.4, 'H': -3.2, 'I': 4.5,
            'L': 3.8, 'K': -3.9, 'M': 1.9, 'F': 2.8, 'P': -1.6,
            'S': -0.8, 'T': -0.7, 'W': -0.9, 'Y': -1.3, 'V': 4.2
        }
        
        return [hydrophobicity_scale.get(aa, 0) for aa in sequence]
```

---

*This guide covers bioinformatics fundamentals including sequence analysis, genomic data processing, and protein structure prediction.*
