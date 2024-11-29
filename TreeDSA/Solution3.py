from collections import deque

def ladderLength(beginWord: str, endWord: str, wordList: set) -> int:
    if endWord not in wordList:
        return 0

    queue = deque([(beginWord, 1)])  # (current_word, current_length)
    visited = set([beginWord])

    while queue:
        current_word, current_length = queue.popleft()

        # Generate all possible transformations
        for i in range(len(current_word)):
            for c in 'abcdefghijklmnopqrstuvwxyz':
                next_word = current_word[:i] + c + current_word[i+1:]

                if next_word == endWord:
                    return current_length + 1

                if next_word in wordList and next_word not in visited:
                    visited.add(next_word)
                    queue.append((next_word, current_length + 1))

    return 0
