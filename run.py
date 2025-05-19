import json
import time

def main():

    # Open and read the JSON file
    with open('example_1.json', 'r') as file:
        data = json.load(file)

    while 1 != 0:
        # Print the data every 10 seconds forever
        # print(data)
        # Print individual element by specified key
        print(data['fruit'])

        # Print each key and value
        for key, value in data.items():
            print(key, value)
        time.sleep(10)        

if __name__ == "__main__":
    main()