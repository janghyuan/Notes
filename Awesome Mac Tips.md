## 软件篇

- AppCleaner https://freemacsoft.net/appcleaner/

![appcleaner](https://freemacsoft.net/img/appcleaner.png)

## 系统设置篇

- 将屏幕右上角设置为‘触发角’的调度中心以便快速切换程序（只需将鼠标移动到桌面右上角）

## 

## Mac 操作技巧篇

- 空格键可以预览系统支持的任意文件，‘按住’空格键可以打开预览，松开即可关闭预览，而不需要按两次按键。
- `Shift` + `Option` + `Command` + `v` 将粘贴的文本按照当前文档的格式进行格式化
- 用鼠标按住窗口‘最大化’按钮可以将屏幕拆分
- 屏幕截图：
  - `Shift` + `Command` + `3` 全屏
  - `Shift` + `Command` + `4` 自由选取 `Space`: 调整选取位置 `Option` : 调整选区的 4 个角的位置
  - `Ctrl` + 屏幕截图 : 将截图复制到剪贴板
- 系统的 Emoji : `Ctrl` + `Command` + `Space` 
- `Option` + 鼠标移动文件：制作副本；`Option` + `Command` + 鼠标移动文件：制作链接

## Chrome 技巧篇

- 在 YouTube 视频上右键点击 2 次，将会出现‘画中画’选项
- 

## Terminal

- `brew install htop` 系统运行程序监视器
- `brew install cask` 安装非 AppStore 的程序
  - `brew cask install chrome` 
- `brew install speedtest-cli` 命令行测网速
- `brew install youtube-dl ffmpeg` 
  - `youtube-dl -f bestvideo+bestaudio youtube_url`
- `brew install imagemagick` 然后使用 `convert` 命令
  - `convert origin.png -resize 1920x1080 output.png`
  - `convert origin.png -border 20x20 -bordercolor white output.png`
  - `for file in *.png; do convert \$file -resize 50% small-\$file; done`
- 