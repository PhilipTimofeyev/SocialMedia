import consumer from "channels/consumer"

const followChannel = consumer.subscriptions.create("FollowChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // alert("Works")
    console.log(data.data)
    const followDisplay = document.querySelector('#follow-display')
    followDisplay.insertAdjacentHTML('beforeend', this.template(data))
  },

  template(data) {
    return `<article class="follow">
                <p>${data.from_user.email} would like to follow you. Accept follow request?</p>
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