import consumer from "channels/consumer"

const followChannel = consumer.subscriptions.create("FollowChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data.data)
    const followDisplay = document.querySelector('#follow-display')
    followDisplay.insertAdjacentHTML('beforeend', this.template(data))
  },

  template(data) {
    console.log(data)
    return `<article class="follow-request">
                <p>${data.from_user.email} would like to follow you. Accept follow request?</p>
                  <form action="/follows" method="post" id="accept-form">
                  <input id="from" name="from_user" type="hidden" value=${data.from_user.id}/>
                    <button type="submit" id="accept-form">Submit</button>
                  </form>
                </form>
            </article>`
  }
});

document.addEventListener("turbo:load", () => {
  let form = document.querySelector('#follow-form')
  if(form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault()
      alert("no")
      let followInput = document.querySelector('#follow-input').firstElementChild.getAttribute('id')
      const follow = {
        user_id: followInput
      }
      followChannel.send({follow: follow})
    })
  }
  })

