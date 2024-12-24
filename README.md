# 🌐 Weview.nvim
Weview.nvim is a Neovim plugin that allows you to search the web using predefined search engines or aliases, directly from your editor. It's fully customizable—you can add new search engines, set up aliases, and even rename the command to suit your preferences.

## 🚀 Installation
Here's how to install Weview.nvim using lazy.nvim:

```lua
{
  "mei28/Weview.nvim",
  config = function()
    require("weview").setup({
      search_urls = {
        StackOverflow = "https://stackoverflow.com/search?q=%s",
        Bing = "https://www.bing.com/search?q=%s",
      },
      aliases = {
        so = "StackOverflow",
        b = "Bing",
      },
      command_name = "Find", -- Rename the default command
    })
  end,
}
```
## ✨ Features
- **Customizable Search Engines:** Add and manage multiple search engines.
- **Alias Support:** Quickly invoke search engines using shorthand aliases.
- **Command Name Customization:** Rename the command to anything you like.
- **Completion:** Autocompletion for search engines and aliases.
## 🔧 Configuration
### setup Options

| Option Name  | Type  | Description                                            | Default                            |
|--------------|-------|--------------------------------------------------------|------------------------------------|
| search_urls  | Table | A mapping of search engine names to URL templates.     | Google, GitHub, DeepL              |
| aliases      | Table | A mapping of shorthand aliases to search engine names. | g → Google, gh → GitHub, d → DeepL |
| command_name | String| The command name to invoke the plugin.                 | "Weview"                           |

## 🌟 Usage
Basic Search
Run the following commands to search using predefined search engines:

```vim
:Weview Google "Neovim tutorial"
:Weview g "Lua string manipulation"
```

Using Aliases
Search using shorthand aliases for faster access:
```vim
:Weview gh "telescope.nvim"
:Weview d "translate this to Japanese"
```
Customizing Settings
Customize the behavior by modifying the setup configuration.

## 🔄 Default Configuration
Weview.nvim comes with the following default configuration:

```lua
require("weview").setup({
  search_urls = {
    Google = "https://www.google.com/search?q=%s",
    GitHub = "https://github.com/search?q=%s",
    DeepL = "https://www.deepl.com/ja/translator#en/ja/%s",
  },
  aliases = {
    g = "Google",
    gh = "GitHub",
    d = "DeepL",
  },
  command_name = "Weview",
})
```

## 🧩 Customization Examples
Adding New Search Engines
Add Stack Overflow and Bing as new search engines:

```lua
require("weview").setup({
  search_urls = {
    StackOverflow = "https://stackoverflow.com/search?q=%s",
    Bing = "https://www.bing.com/search?q=%s",
  },
  aliases = {
    so = "StackOverflow",
    b = "Bing",
  },
})
```
Renaming the Command
Change the default command name to Search:

```lua
require("weview").setup({
  command_name = "Search",
})
```
## 🌐 How It Works
- Default Command: The command opens the browser using open on macOS or xdg-open on Linux.
- Search Query Encoding: Queries are URL-encoded to ensure compatibility with search engines.
- Completion: Both search engine names and aliases are included in the autocompletion suggestions.
## ❤️ Contributions
We welcome bug reports and feature requests! Feel free to open an issue or submit a pull request.

### 📜 License
This plugin is licensed under the MIT License.
