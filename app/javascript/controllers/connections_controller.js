import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="connections"
export default class extends Controller {
  static targets = ["connection"]
  connect() {
  }

  initialize() {
    this.element.setAttribute("data-action", "click->connections#prepareConnectionParams")
    console.log("initialize")
  }

  prepareConnectionParams(){
    console.log("prepareConnectionParams");
    event.preventDefault()
    this.url = this.element.getAttribute("href")
    console.log(this);
    const element = this.connectionTarget
    
    const requesterId = element.dataset.requesterId
    const connectedId = element.dataset.connectedId
    const connectionBody = new FormData()
    connectionBody.append("connection[user_id]", requesterId)
    connectionBody.append("connection[connected_user_id]", connectedId)
    connectionBody.append("connection[status]", "pending")

    fetch(this.url, {
      method: "POST",
      headers: {
        Accept: "text/vnd.turbo-stream.html",
        'X-CSRFToken': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: connectionBody
    })
    .then(resp => resp.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
