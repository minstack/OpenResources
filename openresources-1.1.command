#!/usr/bin/python

import webbrowser
import os
import time
#from selenium import webdriver


input = ""
BACKEND = "https://backend.vendhq.com/retailer?prefix="
BACKENDRETAILER = "https://backend.vendhq.com/retailer_redirect/"
TRELLO = "https://trello.com/search?q=board%3A%22SUPPORT%20INTERNAL%20KNOWLEDGEBASE%22%20"
ARTICLES = "https://support.vendhq.com/hc/en-us/search?query="
PTS = "https://vendhelp.zendesk.com/agent/search/1"
VENDYT = "https://www.youtube.com/user/VendHQ/search?query="
ZENDPT = "https://vendhelp.zendesk.com/api/v2/search.json?query=ticket_type:problem%20subject:"
ZENDTICKET = "https://vendhelp.zendesk.com/agent/tickets/"

def processInput(input):
    domain = ""
    keywords = ""

    if "," not in input:
        print "Please add a comma even if you are looking up only domains or keywords: [domain], OR , [keywords]"
    else:
        temp = input.split(",")

        domain = temp[0].strip()
        keywords = temp[1].strip().replace(" ","+")


    return {'domain':domain, 'keywords': keywords}

## seems like too much work to be practical from intial testing
## need to figure out an easier way or how the search is queried
## isn't using typical query strings -> realtime JS searching/filtering
def searchProblemTickets(keywords):
    PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
    DRIVER_BIN = os.path.join(PROJECT_ROOT, "bin/chromedriver_for_mac")

    driver = webdriver.Chrome(executable_path = DRIVER_BIN)
    driver.get(PTS)

    search_input_box = driver.find_element_by_class_name("classic_input query-field")
    search_input_box.send_keys("status:open ticket_type:problem aep " + keywords.replace('+', ' '))

def openResources(searchQuery):
    urls = []

    if searchQuery['domain']:
        #urls.append(BACKEND + searchQuery['domain'])
        urls.append(BACKEND + searchQuery['domain'])

    if searchQuery['keywords']:
        urls.append(TRELLO + searchQuery['keywords'])
        urls.append(ARTICLES + searchQuery['keywords'])
        urls.append(VENDYT + searchQuery['keywords'])
        #urls.append(PTS)

    ## opening first resource in new window
    ## and any others in new tab of this new window.
    ## to have 'clean' sessions per retailer
    #webbrowser.get(CHROME_PATH).open_new(urls[0])

    #this was the only way to actually open a new window/instance of Chrome
    #this is to make each 'session' clean and relevant to a retailer/call
    try:
        os.system('open -na "Google Chrome" --args --new-window {}'.format(urls[0]))
    except:
        webbrowser.open_new(urls[0]) #fallback just in case script can't find chrome

    time.sleep(1) #needed to 'guarantee' the subsequent tabs are added to the new window

    i = 1
    while i < len(urls):
        #if PTS == urls[i]:
        #    searchProblemTickets(searchQuery['keywords'])
        #else:
        webbrowser.open_new_tab(urls[i])

        i += 1
    #for url in urls:
    #    webbrowser.open_new_tab(url)


def getInput():
    return raw_input("Enter store domain and/or keywords (1 to quit): ")



if __name__ == '__main__':
    os.system('cls' if os.name == 'nt' else 'clear')

    while True:
    #    os.system('cls' if os.name == 'nt' else 'clear')

        input = getInput()

        if len(input.strip()) == 0:
            print "Please enter a domain and/or keywords."
            continue

        if input == "1":
            print "Quitting..."
            break;

        result = processInput(input)

        if not result['domain'] and not result['keywords']:
            continue

        openResources(result)
