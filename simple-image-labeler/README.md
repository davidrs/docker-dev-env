
## Usage
- Put unsorted images in uncategorized.
- update main.py 'key_codes' for desired categories and key bindings:
Example, numbers are python keyboard key codes.
```
key_codes = {
    '97':'hotel',      # 'a'
    '108':'not-hotel', # 'l'
    '32':'unsure'      # 'spacebar'
}
```
- Run `python main.py` !from within `simple-image-labeler` since we use relative paths.
- Sort images based on key codes provided. In the example Tap 'a' and 'l' keys to sort images. spacebar to skip images.

## To run code in docker on Mac:
See README.md in parent folder to get cv2.imshow working in docker on a mac.
