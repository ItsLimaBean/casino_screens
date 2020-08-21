# casino_screens
Draws the typical falling diamonds video when inside of the casino.  
Requires your server to be running on version 2060.

You can set what video is playing with the `SetScreenType` export.
```lua
exports["casino_screens"]:SetScreenType("snowflakes")
```

List of built-in videos:
| ID | Description |
| --- | --- |
| diamonds | The default video of diamonds falling. |
| skulls | White and black skulls. |
| snowflakes | The winter themed video. |
| winner | The effect played when someone wins the jackpot. |
