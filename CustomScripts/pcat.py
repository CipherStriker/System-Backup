# Cat command for python. this script lets you combine multiple files in certain format.
# Eg - user1:pass1
import argparse
import sys

def read_lines_from_file(filename):
    try:
        with open(filename, 'r') as file:
            lines = [line.strip() for line in file]
        return lines
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        sys.exit(1)
    except IOError:
        print(f"Error: Could not read file '{filename}'.")
        sys.exit(1)

def generate_cluster_bomb_combinations(usernames, passwords):
    combinations = []
    for username in usernames:
        for password in passwords:
            combinations.append(f"{username}:{password}")
    return combinations

def generate_pitch_fork_combinations(usernames, passwords):
    if len(usernames) != len(passwords):
        print("Error: The number of usernames and passwords must be the same for pitch fork format.")
        sys.exit(1)
    
    combinations = []
    for username, password in zip(usernames, passwords):
        combinations.append(f"{username}:{password}")
    return combinations

def main():
    parser = argparse.ArgumentParser(description="Generate username:password combinations.")
    parser.add_argument("usernames_file", help="File containing usernames")
    parser.add_argument("passwords_file", help="File containing passwords")
    parser.add_argument("-f", "--format", choices=["cluster_bomb", "pitch_fork"], required=True, help="Output format (cluster_bomb or pitch_fork)")

    args = parser.parse_args()

    usernames = read_lines_from_file(args.usernames_file)
    passwords = read_lines_from_file(args.passwords_file)

    if args.format == "cluster_bomb":
        combinations = generate_cluster_bomb_combinations(usernames, passwords)
    elif args.format == "pitch_fork":
        combinations = generate_pitch_fork_combinations(usernames, passwords)

    for combination in combinations:
        print(combination)

if __name__ == "__main__":
    main()
