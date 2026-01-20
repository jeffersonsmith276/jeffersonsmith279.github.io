function pressKey(key) {
            const wordsInput = document.getElementById("wordsInput");
            if (!wordsInput) return;

            const keydownEvent = new KeyboardEvent('keydown', {
                key: key,
                code: key === ' ' ? 'Space' : `Key${key.toUpperCase()}`,
                keyCode: key.charCodeAt(0),
                which: key.charCodeAt(0),
                bubbles: true,
                cancelable: true,
                composed: true
            });
            wordsInput.dispatchEvent(keydownEvent);

            wordsInput.value += key;

            const inputEvent = new InputEvent('input', {
                inputType: 'insertText',
                data: key,
                bubbles: true,
                cancelable: false,
                composed: true
            });
            wordsInput.dispatchEvent(inputEvent);

            const keyupEvent = new KeyboardEvent('keyup', {
                key: key,
                code: key === ' ' ? 'Space' : `Key${key.toUpperCase()}`,
                keyCode: key.charCodeAt(0),
                which: key.charCodeAt(0),
                bubbles: true,
                cancelable: true,
                composed: true
            });
            wordsInput.dispatchEvent(keyupEvent);

            const changeEvent = new Event('change', { bubbles: true });
            wordsInput.dispatchEvent(changeEvent);
};

let canRun = true;
let numberOfRuns = 0;
let interval = 0;

function typer() {
            canRun = false;
            setTimeout( () => {
            let currentword = document.getElementsByClassName('word active');
            let currentArray = Array.from(currentword);
            currentArray[0].querySelectorAll('letter').forEach(letters => {pressKey(letters.innerText)});
            pressKey(' ');
            canRun = true;
            startTyping();   
            }, 250);  
};

function startTyping() {
        const wordContainer = document.getElementById('words');
        wordContainer.querySelectorAll('div').forEach(divs => {numberOfRuns++;});
        if (canRun && numberOfRuns >= interval) {
            typer();
            interval++;
        }
};

document.addEventListener('keydown', e => {if (e.code === 'ArrowDown') {startTyping();}});