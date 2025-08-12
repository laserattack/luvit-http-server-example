/*
 * Устанавливает тикер - функцию, которая выполняется
 * раз в интервал времени (в миллисекундах)
 */
function setTicker(f, interval) {
    f();
    return setInterval(() => {
        f();
    }, interval);
}

setTicker(() => {
    fetch('/api/lastfm')
        .then(response => { return response.json(); })
        .then(data => {
            const track_name = data.name.replace("🅴", "[E]");
            const artist_name = data.artist["#text"];
            const replacement = `${track_name} – ${artist_name}`
            const lastfmElement = document.getElementById("lastfm");
            lastfmElement.textContent = replacement;
        })
        .catch(error => {
            console.error("fetch track error:", error.message);
        });
}, 15000);