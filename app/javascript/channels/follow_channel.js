import consumer from "channels/consumer"

const followChannel = consumer.subscriptions.create("FollowChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const followDisplay = document.querySelector('#follow-display')

    if (data['template'] == 'request') {
      followDisplay.insertAdjacentHTML('beforeend', this.request(data));
    } else {
      followDisplay.insertAdjacentHTML('beforeend', this.accept(data));
    }
  },

  request(data) {
    return `<article class="follow-request">
                <p>${data.from_user.email} would like to follow you. Accept follow request?</p>
                  <form action="/users/${data.from_user.id}/follow" method="patch" id="accept-form">
                  <input id="from" name="from_user" type="hidden" value=${data.from_user.id}/>
                    <button type="submit" id="accept-form">Accept</button>
                  </form>
            </article>`
  },

  accept(data) {
    return `<article class="accept-request">
                <p>${data.from_user.email} has accepted your request!</p>
            </article>`
  }
});

document.addEventListener("turbo:load", () => {
  let form = document.querySelector('#follow-form')
  if(form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault()
      let followInput = document.querySelector('#follow-input').firstElementChild.getAttribute('id')
      const follow = {
        user_id: followInput
      }
      followChannel.send({follow: follow})
    })
  }
  })

