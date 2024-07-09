# Blog

https://immense-castle-96686-8ed3cc3852c4.herokuapp.com/users/sign_in

This Ruby on Rails project is built to demonstrate a blog type site similar to Reddit or Instagram.

Users are able to:

- Create posts using rich text.

- Sign in and out.

- Post or add images to their posts.

- Comment and like posts.

- Create follow requests and follow other users.

- Create a profile page with a profile picture.

  

  <img src="/Users/philiptimofeyev/Desktop/Screenshot 2024-07-09 at 7.48.47 AM.png" alt="Screenshot 2024-07-09 at 7.48.47 AM" style="zoom: 33%;" />

#### Features:

##### Accounts:

I'm Listening is only accessible to users with accounts, which are created and handled by the Devise gem using the PostgreSQL database. When creating an account, a user provides a username and email, which must be unique, as well as a password. The user has the option of adding a profile picture. If one is not added, a default image is set.

##### Followers:

Users are able to see links to other users on the main "User" page. Here, a button next to a user's username displays the follow status between the current user and a different user. There are three states for a button: 

<img src="/Users/philiptimofeyev/Desktop/Screenshot 2024-07-09 at 7.48.59 AM.png" alt="Screenshot 2024-07-09 at 7.48.59 AM" style="zoom:33%;" />

- Follow

  - By selecting "Follow", a follow request is sent to the selected User using Rails action cable. If the other user is online, they will instantly receive a notifcation letting them know a user has requested to follow them. 

    <img src="/Users/philiptimofeyev/Desktop/Screenshot 2024-07-09 at 7.44.09 AM.png" alt="Screenshot 2024-07-09 at 7.44.09 AM" style="zoom:50%;" />

  - They then have the option to select "Accept" or "Decline". If they select "Accept", the inital user will instantly receive a notification that their follow request has been accepted. 

    <img src="/Users/philiptimofeyev/Desktop/Screenshot 2024-07-09 at 7.44.17 AM.png" alt="Screenshot 2024-07-09 at 7.44.17 AM" style="zoom:50%;" />

  - If the user the request was sent to chooses not to respond to the notification, or is not online, they will have a request with the same options on their profile page.

  - Once a User is following another user, they will be able to the see, like, and comment on posts from the other user.

- Delete Request

  - By selecting "Delete Request", the original follow request sent to another user will be deleted and removed from their requests on their profile page.

- Unfollow

  - If the other user accepted the request, and the current user wishes to unfollow the other user, they may select "Unfollow" and the follow will be removed and the current user will no longer see posts from the other user.



##### Images using Active Storage and AWS S3

Images are able to be used in two ways, setting a profile picture or adding an image to a post. Using active storage connected to Amazon's S3 service, users are able to upload and post pictures as well as set a specific picture for their profile. 



##### Posts, Comments, and Likes

Users are able to create posts using rich text, comment on posts, and like/unlike posts. 

Posts can be edited and deleted while comments can only be deleted.

Likes are updated using Hotwire Turbo. 

