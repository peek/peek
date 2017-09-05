var requestId;

requestId = null;

(function() {
  var fetchRequestResults, getRequestId, peekEnabled, toggleBar, updatePerformanceBar, peformUpdate;
  getRequestId = function() {
    if (requestId != null) {
      return requestId;
    } else {
      return document.getElementById('peek').getAttribute('data-request-id');
    }
  };
  peekEnabled = function() {
    return document.contains(document.getElementById('peek'));
  };
  updatePerformanceBar = function(results) {
    var key, label;
    for (key in results.data) {
      for (label in results.data[key]) {
        document.querySelector("[data-defer-to=" + key + "-" + label + "]").textContent = results.data[key][label];
      }
    }
    event = document.createEvent('CustomEvent');
    event.initCustomEvent('peek:render', true, true, [getRequestId(), results]);
    document.dispatchEvent(event);
  };
  toggleBar = function(event) {
    var wrapper;
    if (event.target.type === 'input') {
      return;
    }
    if (event.keyCode === 96) {
      wrapper = document.getElementById('peek');
      if (wrapper.classList.contains('disabled')) {
        wrapper.classList.remove('disabled');
        return document.cookie = "peek=true; path=/";
      } else {
        wrapper.classList.add('disabled');
        return document.cookie = "peek=false; path=/";
      }
    }
  };
  fetchRequestResults = function() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
          updatePerformanceBar(JSON.parse(this.responseText));
      }
    };
    xhr.open('GET', '/peek/results?request_id=' + getRequestId(), true);
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.send();
  };
  performUpdate = function() {
    if (peekEnabled()) {
      event = document.createEvent('CustomEvent');
      event.initCustomEvent('peek:update', true, true, {});
      document.dispatchEvent(event);
    }
  }
  document.addEventListener('keypress', toggleBar, false);
  document.addEventListener('peek:update', fetchRequestResults);
  document.addEventListener('page:change', performUpdate);
  document.addEventListener('turbolinks:load', performUpdate);
  document.addEventListener('DOMContentLoaded', performUpdate);
})();
