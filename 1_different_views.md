Goal
----
The goal of this three part exercise is to learn about and get a feel for the three main environments we develop our system in SaleMove in: Browser, Ruby VM and Node.js. Each part of three is separate and runnable on its own. For briefness sake, three environments are referred as Browser, Ruby and Node in the following text.

Prerequisites
-------------
You need to have Ruby 1.9.3 or later installed. [RVM](https://rvm.io/) is suggested for Ruby installation and [NVM](https://github.com/creationix/nvm) is suggested for Node.js installation (or ```brew install nodejs``` if you're on OS X).

Is it working?
--------------
A test program is provided with the exercise to try out the three solutions.


Ruby
----
Write a REST API using Rails to support simple chat service. 

Requirements:
  POST /users
    Parameters: 
      name - user name
    Response:
      201 Created, if the username was not taken and creation succeeded. Response body would have {user_id: 1} with 1 being the user id of the created user. Subsequent requests that require user id will accept that id.
      406 Not Acceptable, if creation was unsuccessful. Response body empty.
  
  POST /messages
    Parameters: 
      user_id - user's id
      text - the chat message
    Response:
      200 OK, if posting succeeded
      500 Server Error, if submitting failed
  
  GET /messages
    Parameters:
      last_message - optional parameter. Only messages with ID greater than last_message will be returned.
    Response:
      200 OK, if there were new messages. Response body: JSON with the following structure: [
        {
          id: 1,
          user_id: 1,
          user_name: 'Paul',
          text: 'This is a message'
        }
      ]

Node
----
Create a chat application on node.js using socket.io. It should support the following:
1. Joining a to the chat service with a name
  'register_name' with data in JSON format { name: 'Tom' }
  responses (listened on client side):
  'register_name:response' with data in form: { result: 'success', name: 'Tom'} in case of success or { result: 'failure', reason: 'Name taken'}. The contents of reason property in error response are not predefined but the property itself should be present and explain the error.
2. Posting messages to the chat service
  'post_message' with data { name: 'Tom', text: 'Hello!' }
3. Client should be able to receive messages from other chat participants through listening for 'incoming_message'. It would have data in the format of { name: 'Paul', text: 'Wadup.'}

Browser
-------
Create one page chat. It would have two split window with message entry input box and textarea where the messages posted (through pressing enter after typing a message in message entry input box). When message is entered it is 'sent'. It should then appear in the both 'posted messages' boxes.
