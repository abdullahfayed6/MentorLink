# Robotics & Autonomous Systems

## Table of Contents
- [Introduction](#introduction)
- [Robot Kinematics & Dynamics](#robot-kinematics--dynamics)
- [Sensors & Perception](#sensors--perception)
- [Path Planning & Navigation](#path-planning--navigation)
- [Control Systems](#control-systems)
- [Machine Learning in Robotics](#machine-learning-in-robotics)
- [Autonomous Vehicle Systems](#autonomous-vehicle-systems)
- [Human-Robot Interaction](#human-robot-interaction)

## Introduction

Robotics and autonomous systems combine mechanical engineering, electrical engineering, and computer science to create intelligent machines capable of performing tasks in dynamic environments.

## Robot Kinematics & Dynamics

### Forward Kinematics
```python
import numpy as np
from scipy.spatial.transform import Rotation as R

class RobotArm:
    def __init__(self, dh_parameters):
        self.dh_params = dh_parameters  # [a, alpha, d, theta]
        self.num_joints = len(dh_parameters)
    
    def dh_transform(self, a, alpha, d, theta):
        """Denavit-Hartenberg transformation matrix"""
        ct, st = np.cos(theta), np.sin(theta)
        ca, sa = np.cos(alpha), np.sin(alpha)
        
        return np.array([
            [ct, -st*ca,  st*sa, a*ct],
            [st,  ct*ca, -ct*sa, a*st],
            [0,   sa,     ca,    d   ],
            [0,   0,      0,     1   ]
        ])
    
    def forward_kinematics(self, joint_angles):
        """Calculate end-effector pose from joint angles"""
        T = np.eye(4)
        
        for i, theta in enumerate(joint_angles):
            a, alpha, d, theta_offset = self.dh_params[i]
            T_i = self.dh_transform(a, alpha, d, theta + theta_offset)
            T = T @ T_i
        
        return T
```

### Inverse Kinematics
```python
from scipy.optimize import minimize

class InverseKinematics:
    def __init__(self, robot_arm):
        self.robot = robot_arm
    
    def objective_function(self, joint_angles, target_pose):
        """Objective function for optimization"""
        current_pose = self.robot.forward_kinematics(joint_angles)
        
        # Position error
        pos_error = np.linalg.norm(current_pose[:3, 3] - target_pose[:3, 3])
        
        # Orientation error (using rotation matrices)
        R_current = current_pose[:3, :3]
        R_target = target_pose[:3, :3]
        rot_error = np.linalg.norm(R.from_matrix(R_current @ R_target.T).as_rotvec())
        
        return pos_error + rot_error
    
    def solve(self, target_pose, initial_guess=None):
        """Solve inverse kinematics using optimization"""
        if initial_guess is None:
            initial_guess = np.zeros(self.robot.num_joints)
        
        result = minimize(
            self.objective_function,
            initial_guess,
            args=(target_pose,),
            method='BFGS'
        )
        
        return result.x if result.success else None
```

### Dynamics and Control
```python
class RobotDynamics:
    def __init__(self, robot_model):
        self.robot = robot_model
    
    def compute_inertia_matrix(self, q):
        """Compute joint-space inertia matrix M(q)"""
        # Implementation would involve recursive Newton-Euler or Lagrangian methods
        pass
    
    def compute_coriolis_centripetal(self, q, qd):
        """Compute Coriolis and centripetal forces C(q,qd)"""
        pass
    
    def compute_gravity_vector(self, q):
        """Compute gravity compensation vector G(q)"""
        pass
    
    def dynamics_equation(self, q, qd, tau):
        """Robot dynamics: M(q)qdd + C(q,qd)qd + G(q) = tau"""
        M = self.compute_inertia_matrix(q)
        C = self.compute_coriolis_centripetal(q, qd)
        G = self.compute_gravity_vector(q)
        
        qdd = np.linalg.solve(M, tau - C - G)
        return qdd
```

## Sensors & Perception

### LIDAR Processing
```python
import numpy as np
from sklearn.cluster import DBSCAN

class LidarProcessor:
    def __init__(self):
        self.range_threshold = 50.0  # meters
        self.angle_resolution = 0.25  # degrees
    
    def process_scan(self, ranges, angles):
        """Process LIDAR scan data"""
        # Convert to Cartesian coordinates
        valid_indices = ranges < self.range_threshold
        valid_ranges = ranges[valid_indices]
        valid_angles = angles[valid_indices]
        
        x = valid_ranges * np.cos(valid_angles)
        y = valid_ranges * np.sin(valid_angles)
        points = np.column_stack((x, y))
        
        return points
    
    def detect_obstacles(self, points):
        """Cluster points to detect obstacles"""
        clustering = DBSCAN(eps=0.5, min_samples=5)
        labels = clustering.fit_predict(points)
        
        obstacles = []
        for label in set(labels):
            if label == -1:  # Noise points
                continue
            
            cluster_points = points[labels == label]
            centroid = np.mean(cluster_points, axis=0)
            size = np.max(np.linalg.norm(cluster_points - centroid, axis=1))
            
            obstacles.append({
                'centroid': centroid,
                'size': size,
                'points': cluster_points
            })
        
        return obstacles
```

### Computer Vision for Robotics
```python
import cv2
from ultralytics import YOLO

class RobotVision:
    def __init__(self):
        self.model = YOLO('yolov8n.pt')  # Load pre-trained model
        self.camera_matrix = None
        self.dist_coeffs = None
    
    def calibrate_camera(self, calibration_images):
        """Camera calibration using checkerboard pattern"""
        criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)
        
        # Prepare object points
        pattern_size = (9, 6)
        objp = np.zeros((pattern_size[0] * pattern_size[1], 3), np.float32)
        objp[:, :2] = np.mgrid[0:pattern_size[0], 0:pattern_size[1]].T.reshape(-1, 2)
        
        objpoints = []
        imgpoints = []
        
        for img in calibration_images:
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            ret, corners = cv2.findChessboardCorners(gray, pattern_size, None)
            
            if ret:
                objpoints.append(objp)
                corners2 = cv2.cornerSubPix(gray, corners, (11, 11), (-1, -1), criteria)
                imgpoints.append(corners2)
        
        ret, mtx, dist, rvecs, tvecs = cv2.calibrateCamera(
            objpoints, imgpoints, gray.shape[::-1], None, None
        )
        
        self.camera_matrix = mtx
        self.dist_coeffs = dist
        
        return ret, mtx, dist
    
    def detect_objects(self, image):
        """Detect objects using YOLO"""
        results = self.model(image)
        
        detections = []
        for r in results:
            boxes = r.boxes
            for box in boxes:
                x1, y1, x2, y2 = box.xyxy[0].cpu().numpy()
                confidence = box.conf[0].cpu().numpy()
                class_id = int(box.cls[0].cpu().numpy())
                
                detections.append({
                    'bbox': [x1, y1, x2, y2],
                    'confidence': confidence,
                    'class_id': class_id,
                    'class_name': self.model.names[class_id]
                })
        
        return detections
```

## Path Planning & Navigation

### A* Path Planning
```python
import heapq
from collections import defaultdict

class AStarPlanner:
    def __init__(self, occupancy_grid):
        self.grid = occupancy_grid
        self.rows, self.cols = occupancy_grid.shape
    
    def heuristic(self, a, b):
        """Manhattan distance heuristic"""
        return abs(a[0] - b[0]) + abs(a[1] - b[1])
    
    def get_neighbors(self, pos):
        """Get valid neighboring cells"""
        neighbors = []
        directions = [(-1,0), (1,0), (0,-1), (0,1), (-1,-1), (-1,1), (1,-1), (1,1)]
        
        for dx, dy in directions:
            new_pos = (pos[0] + dx, pos[1] + dy)
            
            if (0 <= new_pos[0] < self.rows and 
                0 <= new_pos[1] < self.cols and
                self.grid[new_pos] == 0):  # Free space
                neighbors.append(new_pos)
        
        return neighbors
    
    def plan_path(self, start, goal):
        """A* pathfinding algorithm"""
        open_set = [(0, start)]
        came_from = {}
        g_score = defaultdict(lambda: float('inf'))
        g_score[start] = 0
        f_score = defaultdict(lambda: float('inf'))
        f_score[start] = self.heuristic(start, goal)
        
        while open_set:
            current = heapq.heappop(open_set)[1]
            
            if current == goal:
                # Reconstruct path
                path = []
                while current in came_from:
                    path.append(current)
                    current = came_from[current]
                path.append(start)
                return path[::-1]
            
            for neighbor in self.get_neighbors(current):
                tentative_g_score = g_score[current] + 1
                
                if tentative_g_score < g_score[neighbor]:
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = g_score[neighbor] + self.heuristic(neighbor, goal)
                    heapq.heappush(open_set, (f_score[neighbor], neighbor))
        
        return None  # No path found
```

### RRT (Rapidly-Exploring Random Tree)
```python
import random
import numpy as np

class RRTPlanner:
    def __init__(self, start, goal, obstacle_list, rand_area, 
                 expand_dis=3.0, path_resolution=0.5, max_iter=500):
        self.start = Node(start[0], start[1])
        self.end = Node(goal[0], goal[1])
        self.min_rand = rand_area[0]
        self.max_rand = rand_area[1]
        self.expand_dis = expand_dis
        self.path_resolution = path_resolution
        self.max_iter = max_iter
        self.obstacle_list = obstacle_list
        self.node_list = []
    
    def planning(self):
        """RRT path planning"""
        self.node_list = [self.start]
        
        for _ in range(self.max_iter):
            # Generate random node
            rnd_node = self.get_random_node()
            
            # Find nearest node
            nearest_ind = self.get_nearest_node_index(self.node_list, rnd_node)
            nearest_node = self.node_list[nearest_ind]
            
            # Expand tree
            new_node = self.steer(nearest_node, rnd_node, self.expand_dis)
            
            if self.check_collision(new_node, self.obstacle_list):
                self.node_list.append(new_node)
                
                # Check if goal is reached
                if self.calc_dist_to_goal(new_node.x, new_node.y) <= self.expand_dis:
                    final_node = self.steer(new_node, self.end, self.expand_dis)
                    if self.check_collision(final_node, self.obstacle_list):
                        return self.generate_final_course(len(self.node_list) - 1)
        
        return None  # Cannot find path
    
    def steer(self, from_node, to_node, extend_length=float("inf")):
        """Steer from one node to another"""
        new_node = Node(from_node.x, from_node.y)
        d, theta = self.calc_distance_and_angle(new_node, to_node)
        
        new_node.path_x = [new_node.x]
        new_node.path_y = [new_node.y]
        
        if extend_length > d:
            extend_length = d
        
        n_expand = math.floor(extend_length / self.path_resolution)
        
        for _ in range(n_expand):
            new_node.x += self.path_resolution * math.cos(theta)
            new_node.y += self.path_resolution * math.sin(theta)
            new_node.path_x.append(new_node.x)
            new_node.path_y.append(new_node.y)
        
        d, _ = self.calc_distance_and_angle(new_node, to_node)
        if d <= self.path_resolution:
            new_node.path_x.append(to_node.x)
            new_node.path_y.append(to_node.y)
        
        new_node.parent = from_node
        
        return new_node
```

## Control Systems

### PID Controller
```python
import time

class PIDController:
    def __init__(self, kp, ki, kd, setpoint=0, output_limits=(None, None)):
        self.kp, self.ki, self.kd = kp, ki, kd
        self.setpoint = setpoint
        self.output_limits = output_limits
        
        self._last_error = 0.0
        self._last_time = time.time()
        self._integral = 0.0
    
    def update(self, current_value):
        """Update PID controller"""
        current_time = time.time()
        dt = current_time - self._last_time
        
        if dt <= 0.0:
            return 0.0
        
        error = self.setpoint - current_value
        
        # Proportional term
        p_term = self.kp * error
        
        # Integral term
        self._integral += error * dt
        i_term = self.ki * self._integral
        
        # Derivative term
        d_term = self.kd * (error - self._last_error) / dt
        
        # Combine terms
        output = p_term + i_term + d_term
        
        # Apply output limits
        if self.output_limits[0] is not None:
            output = max(output, self.output_limits[0])
        if self.output_limits[1] is not None:
            output = min(output, self.output_limits[1])
        
        self._last_error = error
        self._last_time = current_time
        
        return output
    
    def reset(self):
        """Reset controller state"""
        self._integral = 0.0
        self._last_error = 0.0
        self._last_time = time.time()
```

### Model Predictive Control (MPC)
```python
import numpy as np
from scipy.optimize import minimize

class ModelPredictiveController:
    def __init__(self, A, B, Q, R, horizon=10):
        self.A = A  # State transition matrix
        self.B = B  # Control input matrix
        self.Q = Q  # State cost matrix
        self.R = R  # Control cost matrix
        self.horizon = horizon
        self.n_states = A.shape[0]
        self.n_controls = B.shape[1]
    
    def predict_trajectory(self, x0, u_sequence):
        """Predict state trajectory given control sequence"""
        trajectory = [x0]
        x = x0
        
        for u in u_sequence:
            x = self.A @ x + self.B @ u
            trajectory.append(x)
        
        return np.array(trajectory)
    
    def cost_function(self, u_flat, x0, reference):
        """Cost function for MPC optimization"""
        u_sequence = u_flat.reshape((self.horizon, self.n_controls))
        trajectory = self.predict_trajectory(x0, u_sequence)
        
        cost = 0.0
        
        # State tracking cost
        for k in range(1, self.horizon + 1):
            error = trajectory[k] - reference[k-1]
            cost += error.T @ self.Q @ error
        
        # Control effort cost
        for k in range(self.horizon):
            cost += u_sequence[k].T @ self.R @ u_sequence[k]
        
        return cost
    
    def optimize(self, x0, reference, u_bounds=None):
        """Solve MPC optimization problem"""
        u_initial = np.zeros(self.horizon * self.n_controls)
        
        bounds = None
        if u_bounds:
            bounds = [u_bounds] * (self.horizon * self.n_controls)
        
        result = minimize(
            self.cost_function,
            u_initial,
            args=(x0, reference),
            method='SLSQP',
            bounds=bounds
        )
        
        u_optimal = result.x.reshape((self.horizon, self.n_controls))
        return u_optimal[0]  # Return first control action
```

## Machine Learning in Robotics

### Reinforcement Learning for Robot Control
```python
import torch
import torch.nn as nn
import numpy as np
from collections import deque
import random

class DQNAgent:
    def __init__(self, state_dim, action_dim, lr=0.001):
        self.state_dim = state_dim
        self.action_dim = action_dim
        self.memory = deque(maxlen=10000)
        self.epsilon = 1.0
        self.epsilon_decay = 0.995
        self.epsilon_min = 0.01
        
        # Neural networks
        self.q_network = self.build_network()
        self.target_network = self.build_network()
        self.optimizer = torch.optim.Adam(self.q_network.parameters(), lr=lr)
        
    def build_network(self):
        return nn.Sequential(
            nn.Linear(self.state_dim, 64),
            nn.ReLU(),
            nn.Linear(64, 64),
            nn.ReLU(),
            nn.Linear(64, self.action_dim)
        )
    
    def remember(self, state, action, reward, next_state, done):
        self.memory.append((state, action, reward, next_state, done))
    
    def act(self, state):
        if np.random.random() <= self.epsilon:
            return random.randrange(self.action_dim)
        
        state_tensor = torch.FloatTensor(state).unsqueeze(0)
        q_values = self.q_network(state_tensor)
        return q_values.argmax().item()
    
    def train(self, batch_size=32):
        if len(self.memory) < batch_size:
            return
        
        batch = random.sample(self.memory, batch_size)
        states, actions, rewards, next_states, dones = zip(*batch)
        
        states = torch.FloatTensor(states)
        actions = torch.LongTensor(actions)
        rewards = torch.FloatTensor(rewards)
        next_states = torch.FloatTensor(next_states)
        dones = torch.BoolTensor(dones)
        
        current_q_values = self.q_network(states).gather(1, actions.unsqueeze(1))
        next_q_values = self.target_network(next_states).max(1)[0].detach()
        target_q_values = rewards + (0.99 * next_q_values * ~dones)
        
        loss = nn.MSELoss()(current_q_values.squeeze(), target_q_values)
        
        self.optimizer.zero_grad()
        loss.backward()
        self.optimizer.step()
        
        if self.epsilon > self.epsilon_min:
            self.epsilon *= self.epsilon_decay
```

## Autonomous Vehicle Systems

### Vehicle Dynamics Model
```python
class VehicleDynamics:
    def __init__(self, wheelbase=2.7, max_steering=0.6):
        self.wheelbase = wheelbase
        self.max_steering = max_steering
    
    def bicycle_model(self, state, control, dt):
        """Bicycle model for vehicle dynamics"""
        x, y, theta, v = state
        steering, acceleration = control
        
        # Limit steering angle
        steering = np.clip(steering, -self.max_steering, self.max_steering)
        
        # Update state
        x_new = x + v * np.cos(theta) * dt
        y_new = y + v * np.sin(theta) * dt
        theta_new = theta + v * np.tan(steering) / self.wheelbase * dt
        v_new = v + acceleration * dt
        
        return np.array([x_new, y_new, theta_new, v_new])
    
    def kinematic_model_continuous(self, state, control):
        """Continuous-time kinematic model"""
        x, y, theta, v = state
        steering, acceleration = control
        
        x_dot = v * np.cos(theta)
        y_dot = v * np.sin(theta)
        theta_dot = v * np.tan(steering) / self.wheelbase
        v_dot = acceleration
        
        return np.array([x_dot, y_dot, theta_dot, v_dot])
```

### Autonomous Navigation Stack
```python
class AutonomousNavigationStack:
    def __init__(self):
        self.perception = VehiclePerception()
        self.planner = PathPlanner()
        self.controller = VehicleController()
        self.safety_monitor = SafetyMonitor()
    
    def process_frame(self, sensor_data):
        """Main processing loop for autonomous navigation"""
        # 1. Perception
        obstacles = self.perception.detect_obstacles(sensor_data['lidar'])
        lane_lines = self.perception.detect_lanes(sensor_data['camera'])
        traffic_signs = self.perception.detect_traffic_signs(sensor_data['camera'])
        
        # 2. World model update
        world_state = self.update_world_model(obstacles, lane_lines, traffic_signs)
        
        # 3. Path planning
        path = self.planner.plan_path(world_state, self.get_goal())
        
        # 4. Safety check
        if not self.safety_monitor.is_safe(path, obstacles):
            path = self.planner.plan_emergency_path(world_state)
        
        # 5. Control
        control_commands = self.controller.follow_path(path)
        
        return control_commands
    
    def update_world_model(self, obstacles, lanes, signs):
        """Update internal world representation"""
        return {
            'obstacles': obstacles,
            'lanes': lanes,
            'traffic_signs': signs,
            'timestamp': time.time()
        }
```

---

*This guide covers advanced robotics concepts including kinematics, perception, planning, control systems, and autonomous vehicle technologies.*
