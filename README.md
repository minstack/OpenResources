# OpenResources


# BEFORE YOU START:
- Open up terminal and "cd [to the directory you downloaded this]"
- Type "chmod u+x openresources-[version].command"
  - allows the file to be executed by just double-clicking it
- You will need to be logged in with Backend, Trello for this to work seamlessly
- This will loop infinitely until you input '1'

**PURPOSE:**  
          To allow you to search, simultaneously, a retailer domain in Backend
          and/or keywords in Trello Support Knowledge board and Vend's articles.
          Mainly for new support employees who need to refer to resources due
          their initial lack of knowledge of product, workarounds and issues.
          Each new search will open a new window of Chrome with the search
          results.  This was done to make each session 'clean' without having to
          fumble between unrelated tabs of your current Chrome window. After
          each session, you can simply close the Chrome window.
          ** if the script cannot find Google Chrome (for whatever reason), it
          ** will open new tabs in your working window

**USAGE:** *YOU MUST SEPARATE WITH THE COMMA* (see below)
- Search domain and keywords at the same time:
    "[domain], [keywords]"
- Search only domain:
    "[domain],"
- Search only keywords in Trello and support artiles:
    ",[keywords]"

**EXAMPLES:**
  - "demostore, store credit" [Enter]
  - "demostore, " [Enter]
  - ", store credit" [Enter]

**WORKING ON:**
  - Logging a CSV file of each day and searches you do
  - Search keywords in Zendesk open problem tickets
    - This may not work since the search seems to use real-time JavaScript
      to filter search results and no query string, but looking into it
