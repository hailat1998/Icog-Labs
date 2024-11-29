import Tree

def maxPathSum(root: TreeNode) -> int:
    max_sum = float('-inf')  # Initialize to negative infinity

    def dfs(node):
        nonlocal max_sum  # Need this to modify outer function's variable
        if not node:
            return 0

        # Compute the maximum path sum for left and right child
        left_max = max(dfs(node.left), 0)  # Ignore negative sums
        right_max = max(dfs(node.right), 0)  # Ignore negative sums

        # Current path sum including the node itself
        current_sum = node.val + left_max + right_max  # Changed from value to val

        # Update maximum path sum
        max_sum = max(max_sum, current_sum)  # Removed self, using nonlocal variable

        # Return the maximum path sum that can be extended to the parent
        return node.val + max(left_max, right_max)  # Changed from value to val

    dfs(root)
    return max_sum
