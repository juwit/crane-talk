/**
 * Sends a query to the gnome-server
 * @param path
 * @param body
 * @returns {Promise<any>}
 */
function gnome(path, body) {
    return fetch('http://localhost:7000' + path, {
        mode: 'cors',
        method: (body !== null) ? 'POST' : 'GET',
        headers: {
            "Content-Type": "application/json",
        },
        body: (body !== null) ? JSON.stringify(body) : null,
    }).then((r) => console.log(r));
}

async function bashDemo(element) {
    await showDemo(element);
    await gnome("/type", {type:element.nextElementSibling.innerText})
}

async function showDemo(element) {
    console.log(element);

    const demoSlide = document.querySelector("#demo-slide");
    demoSlide.classList.remove("hidden");

    const windowPlaceholder = document.querySelector("#demo-slide-window")
    console.log(windowPlaceholder);

    const windowPosition = windowPlaceholder.getBoundingClientRect();

    await gnome('/show-window', {top: windowPosition.top, left: windowPosition.left, width: windowPosition.width, height: windowPosition.height}).catch(() => null);
}

function hideDemo() {
    const demoSlide = document.querySelector("#demo-slide");
    demoSlide.classList.add("hidden");
}