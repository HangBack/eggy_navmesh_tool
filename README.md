# NavMesh构建工具

这是一个适用于蛋仔派对的NavMesh构建工具，可在运行期构建NavMesh。
该工具编辑行为和使用行为仅存在于蛋仔编辑器，没有额外的图形编辑器。

# 为何使用
蛋仔派对本身不能提前烘焙NavMesh，但是我们可能经常会有一些寻路需求。因此，我们开发了NavMesh构建工具，以便在运行期构建NavMesh。

# 快速开始
将本项目中的`NavMesh`目录以及`ClassUtils.lua`放置于你的蛋仔Lua工程主目录中

接着导入所需文件

```lua
NavMesh = require "NavMesh.__init"
```

完成之后，我们运行游戏，接着可以在EGGITOR控制台输入NavMesh.start_edit()开始编辑

常用指令
| 指令                                     | 说明         | 参数                     |
| ---------------------------------------- | ------------ | ------------------------ |
| NavMesh.start_edit()                     | 开始编辑     | 无                       |
| NavMesh.stop_edit()                      | 停止编辑     | 无                       |
| NavMesh.set_operation(operation: string) | 设置操作模式 | 1是操作模式，2是移除模式 |
| NavMesh.build(config: table)             | 构建NavMesh  | 来自export的lua文件      |
| NavMesh.export()                         | 导出NavMesh  | 无                       |
| NavMesh.render()                         | 渲染节点     | 无                       |
| NavMesh.disable_render()                 | 禁用渲染     | 无                       |

你可以使用内置的寻路模块进行寻路
```lua
NavMesh = require "NavMesh.__init"
Path = require "NavMesh.Path"
local mesh = NavMesh.build(require "ur_mesh_export_path_to")

local start_point = math.Vector(x1, y1, z1)
local end_point = math.Vector(x2, y2, z2)

local nodes = Path.query("astar", mesh, start_point, end_point)
print(nodes) ---从start_point到end_point的寻路节点，延路径移动需要自己实现
```

# 贡献
豆油汉堡