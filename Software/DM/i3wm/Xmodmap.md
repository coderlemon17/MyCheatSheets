# Reset your keyboard

- `setxkbmap` : comes along with ubuntu (can not be installed through apt though)

# Remap Caps Lock to ESC

- ```
    keycode 66 = Escape
    clear lock
    ```

    - if you just do step 1, `Caps Lock` will work as `ESC` and `Caps Lock` at the same time.
    - Guessing that lock is a modifier, and it's physically connected with your key `Caps Lock`, so whenever you hit `Caps Lock`, it will execute the keysym bounded with `lock`.
