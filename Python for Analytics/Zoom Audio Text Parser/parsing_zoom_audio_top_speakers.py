import sys 
import re 


# Q: is the professors name suppose to be included

def top_speakers(file_name):
    # file handling
    try:
        transcript = open(file_name, "r")

    except:
        print("ERROR: {0} is not a found in your present working directory!".format(file_name))
        exit(1)

    # will hold the speaker and the # of words they spoke in the transcript
    speaker_dict = {}

    for line in transcript:
        # using regex to find the speaker lines
        search = re.search("^[A-Za-z]+.+:.+", line)
        
        # speaker lines will get sparsed through 
        try:
            s = search[0]
            
            # extract the name of the speaker 
            name = ""
            for word in s:
                if word == ":":
                    break
                name+=word
            
            # remove name from the words they said
            s = s.replace(name+":", "")
            # list of words spoken
            s_words = s.split()
            # Update the number of words spoken
            speaker_dict[name] = len(s_words) + speaker_dict.get(name, 0)
        
        # non-speaker lines will get skipped
        except:
            continue 
    
    
    # reverse the dictionary, store in list 
    speakers = []  
    for k, v in speaker_dict.items():
        speakers.append((v, k))

    # sort the list in descending order i.e. greatest to least
    speakers = sorted(speakers, reverse=True)

    # print out the top 5 speakers 
    for v, k in speakers[:5]:
        print(k, v)
        

if __name__ == "__main__":
    file_name = sys.argv[1]
    top_speakers(file_name)