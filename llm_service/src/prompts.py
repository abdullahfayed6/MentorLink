"""
Prompt Engineering Module for MentorAI (Chain-of-Thought aware)
Clean, focused prompts that encourage strong internal reasoning while keeping outputs concise.
"""

from typing import List, Dict

class PromptTemplates:
    """Prompt templates using chain-of-thought-aware guidance (no few-shot examples)."""
    
    SYSTEM_PROMPT = SYSTEM_PROMPT = """You are MentorAI, a thoughtful and clear assistant. Be concise, but include enough detail for clarity.

Core principles:
- Be accurate, structured, and practical.
- Privately reason step-by-step. Do not reveal chain-of-thought or internal scratch work.
- Provide explanations with brief context and, when useful, short examples.
- Aim for clarity over extreme brevity; include a bit of detail so answers feel complete.

Internal process (do not show):
1) Understand the request and constraints. 2) Note assumptions and edge cases. 3) Plan a solution in 2–5 steps. 4) Check for risks, gaps, and compliance. 5) Deliver the final answer.

Output requirement:
- Respond with clear, organized answers (1–3 short paragraphs or bullet points).
- Use code snippets or examples when they make the explanation easier to follow.
- Avoid being too summarized; ensure the response feels sufficiently detailed to act on.
- Keep language simple and direct.

Rules:
- Never include hidden scratchpad or verbatim chain-of-thought.
- Do not add labels like “Answer” or “Reasoning”.
- No unnecessary disclaimers.
- If information is uncertain, say so and suggest a practical next step.
"""


    @classmethod
    def get_system_prompt(cls) -> str:
        """Get the system prompt"""
        return cls.SYSTEM_PROMPT

    @classmethod
    def create_enhanced_prompt(cls, user_query: str, context: str = "", 
                             conversation_history: List[Dict] = None, 
                             category: str = "general") -> str:
        """Create enhanced prompt with user query (category is accepted but ignored)."""
        # Static guidance (no category map)
        guidance = "Answer directly with clarity. Keep reasoning private. Be concise but include some detail."

        # Short rolling summary of conversation (if provided) to focus the model,
        # without including prior answers verbatim.
        history_snippet = ""
        if conversation_history:
            try:
                # Capture only last 2 turns' user questions for brevity
                recent_user_msgs = [
                    m.get("content", "") for m in conversation_history if m.get("role") == "user"
                ]
                if recent_user_msgs:
                    last_few = recent_user_msgs[-2:]
                    history_snippet = "\n".join(f"- {q}" for q in last_few)
            except Exception:
                history_snippet = ""

        enhanced_prompt = f"""
Task:
{guidance}

Context:
{context.strip() if context else "(none)"}

Recent related questions (for continuity):
{history_snippet if history_snippet else "(none)"}

Current question:
{user_query}

Follow the system prompt's process: reason privately, then respond in the requested concise format.
"""

        return enhanced_prompt.strip()

