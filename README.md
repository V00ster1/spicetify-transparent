<div align="center">
  <h1>Transparent</h1>

  [Spicetify](https://github.com/khanhas/spicetify-cli) Transparent theme.  
  ### **Consider starring us, and suggest stuff by submitting a comment!**
</div>

<br>

![dark-1](https://raw.githubusercontent.com/sandarutharuneth/spicetify-transparent/main/cover.png)


<br>


![dark-1](https://raw.githubusercontent.com/sandarutharuneth/spicetify-transparent/main/Dark-1.png)

<br>

## Dependencies

- [Spicetify](https://github.com/spicetify/spicetify-cli) version 2.11.1 or newer. Latest version recommended.
- [Segoe UI](https://en.wikipedia.org/wiki/Segoe#Segoe_UI) font family, comes pre-installed on Windows Vista and newer.
  Segoe UI versions older than 5.37 (older than Windows 8.0) are not officially supported but may work.

## Automated Installation

### Windows (Powershell)

```powershell
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/sandarutharuneth/spicetify-transparent/main/install.ps1" | Invoke-Expression
```

### Linux/macOS (Bash)

```bash
curl -fsSL https://raw.githubusercontent.com/sandarutharuneth/spicetify-transparent/main/install.sh | sh
```

...or if you don't want to use shell commands, you can download the installation scripts within the repository.

### Spicetify Marketplace

You may also install the theme from the Spicetify Marketplace.
Simply install [spicetify-marketplace](https://github.com/spicetify/spicetify-marketplace) by following it's
installation instructions. Look for `Transparent` theme and install it.

## Manual Installation
Use this guide to install if you're having trouble using the shell commands/installation scripts.

### Step 1
- Download the theme [ZIP file](https://github.com/sandarutharuneth/spicetify-transparent/archive/refs/heads/main.zip) via the GitHub repository page.

### Step 2
- Navigate to Spicetify's Theme directory.

| Platform            | Path                              |
| ------------------- | --------------------------------- |
| **Windows**         | `%appdata%\spicetify\Themes`      |
| **Linux**/**MacOS** | `~/.config/spicetify/Themes`      |

### Step 3
- In the directory, create a new folder called `Transparent`.

### Step 4
- Open the downloaded theme ZIP file, and extract the following files **highlighted in the screenshot below** to the Transparent folder you created.

### Step 5
- Navigate to Spicetify's Extensions directory.

| Platform            | Path                              |
| ------------------- | --------------------------------- |
| **Windows**         | `%appdata%\spicetify\Extensions`      |
| **Linux**/**MacOS** | `~/.config/spicetify/Extensions`      |

### Step 6
- Go back to the downloaded ZIP file, and extract `transparent.js` to the Extensions directory.

### Step 7
- Open a terminal/command prompt window and type the following commands:
```bash
spicetify config current_theme Transparent
spicetify config color_scheme dark
spicetify config extensions transparent.js
```
...and then apply the theme by typing `spicetify apply`. And you should be done!

<br>

If you encounter any buggy artifacts after applying, type these following commands:
```sh
spicetify config inject_css 1
spicetify config replace_colors 1
spicetify config overwrite_assets 1
```
..then type `spicetify apply` to apply the theme.

## Important

For the sidebar playlists to show properly, ensure that these two lines are added in the Patch section of your `config-xpui.ini` file:

```ini
[Patch]
xpui.js_find_8008 = ,(\w+=)32,
xpui.js_repl_8008 = ,${1}56,
```

## Customization

The available color schemes are: `light` and `dark`. Apply one using the following commands:
```
spicetify config color_scheme <color scheme>
spicetify apply
```

### More Options

- You can change the accent color in the theme folder's color.ini file.  
- If you're using Windows, you can hide the window controls by adding the flag `--transparent-window-controls` after Spotify.exe in your Spotify shortcut.  

## Troubleshooting
<details>
  <summary><b>Experiencing issues after installing via Spicetify Marketplace?</b></summary>
<blockquote> If you're experiencing issues after installing the theme via the Spicetify Marketplace, reset it by going to the Spicetify Marketplace settings, then scroll all the way down until you see the "Reset Marketplace" button. After that, proceed to install the theme using the instation methods shown above. </blockquote>
</details>

<details>
  <summary><b>Theme is broken, some visual elements are missing, etc.</b></summary>
<blockquote> Spotify releases updates very frequently, and when that happens, it's common for things to break. Generally, we'll be able to fix these issues, but there are certain issues that are out of our control. If you experience such an issue, please report them via the repository's issues page.
</details>

## License

[MIT License](LICENSE)
