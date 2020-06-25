# i3wm (super key: alt)



## 快捷键

#### 说明:

- `<mod>` = windows

#### 切换工作区

- `<mod+NUMBER>`: 切换工作区间
- `<mod+shift+NUMBRE>`:将窗口移动到不同工作区

- `<mod+ARROW>`:切换窗口  // `mode + 左下上右=jkl;
- `<mod+shift+ARROW>`:移动窗口 // `<mode + shift + jkl;>`
- `<mod+shift+q>`:关闭窗口

#### 切分工作区

- `<mod+v>`:垂直切分
- `<mod+h>`:水平切分
- `<mod+a>`: focus on parent (可以选择在个节点新建窗口)
- `<mod+w>`:切换为tab模式
- `<mod+s>`:切换为stack模式(只有focus的tab会被显示):
    - 如果先`<mod+a>` fucos parent再`<mod+s>`的话,会把这两个加一个公共祖先
    - 想删掉这个公众祖先的话, 使用focus parent选中这三者,然后`<mod+e>` `<mod+e>`:切换为正常模式
- `<mod+r>`:切换为resize模式 (ARROW可以调整, ESC退出)

#### 打开进程

- `<mod+enter>`: 打开shell
- `<mod+d>`: 打开dmenu,可以打开所有在`$PATH`下的进程

#### 其他

###### 退出登录

- `<mod+shift+e>`:退出i3并退出登录

###### 重启i3

- `<mod+shift+r>`:重启i3 (会保留session)
- `<mod+shift+c`:重新载入配置文件

###### 全屏:

- `<mod+f>`: 全屏

###### 悬浮模式

- `<mod+shift+space>`: 窗口进入悬浮状态, 右键在标题栏按住拖动可以resize

## 多屏

- 使用xrandr查看当前显示器接口

- 复制模式:

    - ```
        xrandr --output HDMI-1-1 --mode 1920x1080 --same-as eDP-1-1 --auto
        ```

- 扩展模式

    - ```
        xrand --output eDP-1-1 --left-of HDMI-1-1 --auto
        ```

        - `--left-of`, `--right-of`, `--above`, `--below`

## 网络

- `https://askubuntu.com/questions/896140/how-to-connect-to-wifi-network-with-i3wm`
- 使用`nmtui` (空格是选中)

## 声音

- 外放:
    - `alsamixer`: 方向键选择,上下调整音量
    - m: mute (`, .`可以选择mute/打开左右声道)

## 注意

- 当你发现按键没有用的时候:
    - 看一底下的status bar,可能是resize模式,也可能是你进入全屏了

## 滚动

- `fn+上/下 = Page_Up/Page_Down`
- `shift+Page_Up/Down = 鼠标滚动 (在zsh里), 一般只要fn + 方向键/ 直接方向键`