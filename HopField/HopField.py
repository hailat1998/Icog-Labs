import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
from typing import List, Tuple

class MultiPatternHopfieldNetwork:
    def __init__(self, size: Tuple[int, int]):
        self.height, self.width = size
        self.size = self.height * self.width
        self.weights = np.zeros((self.size, self.size))
        self.patterns = []  # Store original patterns for comparison
        
    def train(self, images: List[np.ndarray]):
        """Train network with multiple images"""
        self.patterns = [img.flatten() for img in images]
        
        # Calculate weights using all patterns
        for pattern in self.patterns:
            flat = pattern.reshape(self.size)
            self.weights += np.outer(flat, flat)
            
        # Remove self-connections and normalize
        np.fill_diagonal(self.weights, 0)
        self.weights /= len(images)
    
    def recall(self, partial_pattern: np.ndarray, max_iterations: int = 100,
           threshold: float = 0) -> Tuple[np.ndarray, int]:
     """
     Enhanced recall method with improved pattern matching and energy minimization
     """
    # Initialize state
     state = partial_pattern.flatten()
     original_mask = (partial_pattern.flatten() != -1)  # Remember known positions
     best_state = state.copy()
     min_energy = float('inf')

    # Asynchronous update with energy minimization
     for _ in range(max_iterations):
        # Randomly select update order
        update_order = np.random.permutation(self.size)

        changed = False
        for i in update_order:
            if original_mask[i]:  # Skip known positions
                continue

            # Calculate local field
            h = np.dot(self.weights[i], state)
            new_value = 1 if h >= threshold else -1

            if state[i] != new_value:
                state[i] = new_value
                changed = True

        # Calculate current energy
        energy = -0.5 * state.dot(self.weights).dot(state)

        # Update best state if energy is lower
        if energy < min_energy:
            min_energy = energy
            best_state = state.copy()

        if not changed:  # Network has converged
            break

    # Enhanced pattern matching using correlation
     correlations = []
     for pattern in self.patterns:
        correlation = np.abs(np.corrcoef(best_state, pattern)[0,1])
        correlations.append(correlation)

     best_match_idx = np.argmax(correlations)

    # Apply pattern correction
     final_state = best_state.copy()
     for i in range(self.size):
        if not original_mask[i]:
            final_state[i] = self.patterns[best_match_idx][i]

     return final_state.reshape(self.height, self.width), best_match_idx
    
    def pattern_similarity(self, pattern1: np.ndarray, pattern2: np.ndarray) -> float:
        """Calculate similarity between two patterns"""
        return np.sum(pattern1.flatten() == pattern2.flatten()) / self.size

class ImageProcessor:
    @staticmethod
    def process_image(image_path: str, size: Tuple[int, int]) -> np.ndarray:
        """Convert image to binary pattern"""
        img = Image.open(image_path).convert('L')
        img = img.resize(size)
        data = np.array(img)
        return np.where(data > 127, 1, -1)
    
    @staticmethod
    def create_partial_pattern(pattern: np.ndarray, 
                             completion_level: float = 0.5) -> np.ndarray:
        """Create partial pattern with random missing parts"""
        mask = np.random.random(pattern.shape) < completion_level
        partial = np.copy(pattern)
        partial[~mask] = -1
        return partial

def demonstrate_multi_pattern_recall():
    # Initialize network
    image_size = (32, 32)
    network = MultiPatternHopfieldNetwork(image_size)
    processor = ImageProcessor()
    
    # Load and process multiple training images
    image_paths = ['a.png', 'b.png', 'c.png']
    training_patterns = []
    
    for path in image_paths:
        pattern = processor.process_image(path, image_size)
        training_patterns.append(pattern)
    
    # Train network
    network.train(training_patterns)
    
    # Test with partial pattern
    test_idx = 0  # Try to recall second image
    partial_pattern = processor.create_partial_pattern(training_patterns[test_idx])
    
    # Recall and identify
    reconstructed, matched_idx = network.recall(partial_pattern)
    
    # Visualize results
    plt.figure(figsize=(15, 5))
    
    plt.subplot(141)
    plt.imshow(training_patterns[test_idx], cmap='gray')
    plt.title('Original')
    
    plt.subplot(142)
    plt.imshow(partial_pattern, cmap='gray')
    plt.title('Partial Pattern')
    
    plt.subplot(143)
    plt.imshow(reconstructed, cmap='gray')
    plt.title('Reconstructed')
    
    plt.subplot(144)
    plt.imshow(training_patterns[matched_idx], cmap='gray')
    plt.title(f'Matched Pattern (Index: {matched_idx})')
    
    plt.show()

# Enhanced version with memory capacity estimation
class AdvancedMultiPatternHopfieldNetwork(MultiPatternHopfieldNetwork):
    def estimate_capacity(self) -> float:
        """Estimate network's storage capacity"""
        # Theoretical capacity is approximately 0.15N where N is the number of neurons
        return 0.15 * self.size
    
    def validate_patterns(self) -> List[float]:
        """Calculate orthogonality between stored patterns"""
        n_patterns = len(self.patterns)
        orthogonality = []
        
        for i in range(n_patterns):
            for j in range(i + 1, n_patterns):
                similarity = self.pattern_similarity(
                    self.patterns[i].reshape(self.height, self.width),
                    self.patterns[j].reshape(self.height, self.width)
                )
                orthogonality.append(1 - similarity)
                
        return orthogonality

# Usage example
def main():
    demonstrate_multi_pattern_recall()
    network = AdvancedMultiPatternHopfieldNetwork((32, 32))
    processor = ImageProcessor()
    
    # Load multiple images
    image_paths = ['a.png', 'b.png', 'c.png']
    patterns = []
    
    for path in image_paths:
        pattern = processor.process_image(path, (32, 32))
        patterns.append(pattern)
    
    # Train network
    network.train(patterns)
    
    # Print network capacity information
    print(f"Theoretical capacity: {network.estimate_capacity():.0f} patterns")
    orthogonality = network.validate_patterns()
    print(f"Average pattern orthogonality: {np.mean(orthogonality):.2f}")
    
    # Test recall with partial pattern
    test_pattern = processor.create_partial_pattern(patterns[0])
    reconstructed, matched_idx = network.recall(test_pattern)
    
    print(f"Matched with pattern index: {matched_idx}")

if __name__ == "__main__":
    main()
