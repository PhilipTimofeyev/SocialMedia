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
    return `<article id="followrequest">
                <p class="m-0 text-center">${data.user_id.user_name} would like to follow you. Accept follow request?</p>
                  <form action="/follows/${data.user_id.id}" method="patch" id="accept-form" class="text-center">
                    <button type="submit" name="follow[follower]" onclick="document.getElementById('followrequest').hidden=true" value=${data.user_id.id} class="bg-orange-400 hover:bg-orange-300 text-white font-bold text-xs py-1 px-4 rounded">Accept</button>
                    <button type="decline" name="follow[follower]" onclick="history.go(0)" value=${data.user_id.id} formmethod="delete" formaction="/follows/${data.user_id.id}" class="bg-orange-400 hover:bg-orange-300 text-white font-bold text-xs py-1 px-4 rounded">Decline</button>
                  </form>
            </article>`
  },

  accept(data) {
    return `<article class="accept-request text-center">
                <p class="m-0 p-4">${data.user_id.user_name} has accepted your request!</p>
            </article>`
  },

});
