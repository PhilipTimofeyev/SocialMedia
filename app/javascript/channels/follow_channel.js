import consumer from "channels/consumer"

const followChannel = consumer.subscriptions.create("FollowChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const followDisplay = document.querySelector('#follow-display')

    if (data['template'] == 'request') {
      followDisplay.insertAdjacentHTML('beforeend', this.request(data));
    } else {
      followDisplay.insertAdjacentHTML('beforeend', this.accept(data));
    }
  },

  request(data) {
    return `<article class="follow-request">
                <p>${data.user_id.email} would like to follow you. Accept follow request?</p>
                  <form action="/follows/${data.user_id.id}" method="patch" id="accept-form">
                  <input id="from" name="user_id" type="hidden" value=${data.user_id.id}/>
                    <button type="submit" name="accept-form">Accept</button>
                    <button type="decline" name="accept-forms" formmethod="delete" formaction="/follows/${data.user_id.id}">Decline</button>
                  </form>
            </article>`
  },

  accept(data) {
    return `<article class="accept-request">
                <p>${data.user_id.email} has accepted your request!</p>
            </article>`
  }
});

// document.addEventListener("turbo:load", () => {
//   let form = document.getElementById('#haha')
//   console.log(form)
//   if(form) {
//     form.addEventListener('click', (e) => {
//       console.log("lol")
//     })
//   }
//   })

