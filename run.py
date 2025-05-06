import json

def main():

    # Open and read the JSON file
    with open('example_1.json', 'r') as file:
        data = json.load(file)

    # Print the data
    print(data)

if __name__ == "__main__":
    main()