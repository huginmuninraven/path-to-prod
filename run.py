import json
import time

def main():

    # Open and read the JSON file
    with open('example_1.json', 'r') as file:
        data = json.load(file)

    while 1 != 0:
        # Print the data every 10 seconds forever
        print(data)
        time.sleep(10)

if __name__ == "__main__":
    main()