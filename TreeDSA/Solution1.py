import Tree

def max_width_with_nulls(root):
    if not root:
        return 0

    max_width = 0
    # Store nodes and their position indices in the queue
    queue = [(root, 0)]

    while queue:
        level_size = len(queue)
        level = queue.copy()  # Get all nodes at current level

        # Get indices of first and last non-null nodes in current level
        first_index = level[0][1]
        last_index = level[-1][1]

        # Update maximum width
        current_width = last_index - first_index + 1
        max_width = max(max_width, current_width)

        # Process next level nodes
        for _ in range(level_size):
            node, index = queue.pop(0)

            # Only add children if current node is not null
            if node:
                # Left child
                if node.left:
                    queue.append((node.left, 2 * index))
                # Right child
                if node.right:
                    queue.append((node.right, 2 * index + 1))

    return max_width

