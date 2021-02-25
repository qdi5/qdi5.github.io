# 使用vuepress搭建博客网站
## 使用[create-vuepress-site脚手架](https://github.com/vuepress/create-vuepress-site)创建vuepress网站的步骤
1. 执行命令`npx create-vuepress-site`
2. cd docs
3. npm install
4. npm run dev

## 项目说明
### 1、文件目录说明
- `docs/.vuepress`：用于存储全局配置，组件，静态资源等
- `docs/.vuepress/components`：这个目录下的Vue组件将会被自动注册成全局组件
- `docs/.vuepress/theme`：用于存储本地主题
- `docs/.vuepress/styles`：存储与样式有关的文件
- `docs/.vuepress/styles/index.styl`：自动应用的全局样式文件，在css文件的最末尾生成，比默认样式拥有更高的优先级
- `docs/.vuepress/styles/palette.styl`：覆盖默认颜色全局变量，设置Stylus的颜色全局变量
- `docs/.vuepress/public`：静态资源目录
- `docs/.vuepress/templates`：存储HTML模板文件
- `docs/.vuepress/templates/dev.html`：开发环境下的HTML模板文件
- `docs/.vuepress/templates/ssr.html`：构建期间Vue服务端渲染基础HTML模板
- `docs/.vuepress/config.js`：配置的入口文件，也可以是`yml`或`toml`文件
- `docs/.vuepress/enhanceApp.js`：App层面的增强

### 2、默认页面路由
默认以`docs`目录作为`基础目录`，所有相对路径都是基于`docs`目录
|相对路径|页面路由|
|----|----|
|`/README.md`|`/`|
|`/guide/README.md`|`/guide/`|
|`/config.md`|`/config.html`|

### 3、配置
3.1. 所有VuePress相关的文件都将放在`src/.vuepress`目录    

3.2. VuePress内置了基于`headers`的搜索，在所有页面，它会自动从`文章标题`,`h2`,`h3`标签自动建立一个简单的搜索索引。    

3.3. 由于VuePress是一个标准的Vue项目，可以通过创建`.vuepress/enhanceApp.js`来应用app级别的增强，它会被导入到`app`里，这个文件需要`export default`一个钩子函数，这个钩子函数接收一个包含一些app级别的值的对象。你能使用这些钩子去安装额外的Vue插件，注册全局的组件，或者添加额外的路由钩子。

### 4、资源处理
4.1. 相对路径；
所有`Markdown`文件通过webpack被编译成了`Vue组件`;你可以使用相对路径引用所有的静态资源。
```markdown
![An image](./image.png)
```
在vue文件模板里也适用；图片通过`url-loader`和`file-loader`处理，并且被复制到构建后的静态资源目录正确的位置；使用`~`前缀来明确指定这是一个webpack模块请求，允许你使用webpack别名或者npm依赖引用文件。webpack别名能够在`.vuepress/config.js`里面的webpack配置文件里配置
```javascript
module.exports = {
  configureWebpack: {
    resolve: {
      alias: {
        '@alias': 'path/to/some/dir'
      }
    }
  }
}
```    
4.2. 公共文件
有时候，你需要提供的静态资源，不在Markdown或者主题组件中直接引用（比如，favicons和PWA图标）.在这种情况下，你可以直接把它们放到`.vuepress/public`里面，他们将会复制到生成目录的根目录下;

4.3. Base URL
如果你的网站部署的不是根路径，你需要在`.vuepress/config.js`里设置`base`选项.比如，你打算部署你的网站到`https://foo.github.io/bar/`,然后base应该设置为`/bar/`（必须开头和结尾都有斜杠"/"）.    
当base URL存在时，引用`.vuepress/public`里的图片，你必须像这样使用URL：`/bar/image.png`.但是一旦你需要改变`base`的值，这种方式就很脆弱，VuePress提供了一个内置的辅助函数`$withBase`（添加到了vue的原型上），用来生成正确的路径：
```vue
  <img :src="$withBase('/foo.png')" alt="foo">
```    
**上面的语法不仅可以用在主题组件上，也可以用在Markdown文件中**
同样，如果设置了`base`，它会给`.vuepress/config.js`选项中的所有资源路径的前面加上`base`路径

### 5、Markdown扩展
#### 5.1. header锚点；
`h标签`会自带一个锚点链接。可以在`markdown.anchor`选项里配置锚点的渲染规则。
#### 5.2. 链接；
5.2.1. 内部链接
  内部链接会被转换成`<router-link>`作为单页应用的导航。同样，在子目录下的每一个`README.md`或`index.md`将会自动被转换成`index.html`，并带着相应的URL`/` 
  例如，给出如下的目录结构：
  ```markdown
    ├─ README.md
    ├─ foo
    │  ├─ README.md
    │  ├─ one.md
    │  └─ two.md
    └─ bar
      ├─ README.md
      ├─ three.md
      └─ four.md
  ```    
假设你现在在`foo/one.md`中：
```Markdown
[Home](/) <!-- 跳转到根目录下的README.md -->
[foo](/foo/) <!-- 跳转到foo目录下的index.html -->
[bar - three](../bar/three.md) <!-- 具体文件可以使用.md结尾（推荐） -->
[bar - four](../bar/four.html) <!-- 或者可以使用html文件 -->
```    
5.2.2. 链接的重定向
VuePress支持重定向到干净的链接。如果链接`/foo`没有找到，VuePress将会去寻找存在的`/foo/`或`foo.html`.相反，当`/foo/`和`/foo.html`都没找到时，VuePress将会尝试其他路径；有了这个特性，我们能通过官方插件[vuepress-plugin-clean-urls](https://www.npmjs.com/package/vuepress-plugin-clean-urls)自定义网站链接

5.2.3. 页面后缀
页面和内部链接默认会有`.html`后缀。你可以在`config.markdown.pageSuffix`设置里自定义后缀。

5.2.4. 外部链接
外部的链接将会被自动地设置为`target="_blank" rel="noopener noreferrer"`

#### 5.3. Front Matter
VuePress提供了对[YAML front matter](https://jekyllrb.com/docs/front-matter/)开箱即用的支持：
```yaml
title: Blogging Like a Hacker
lang: en-US
```    
这些数据可以在当前markdown的正文，或者是任意的自定义或主题组件中使用。

#### 5.4. Github风格的表格
**输入**
```md
| Tables | Are | Cool |
| ------ | ------: | -----: |
|col 3 is | right-aligned | $1600 |
| col 2 is | centered | $12 |
```

**输出**
| Tables | Are | Cool |
| ------ | ------: | -----: |
|col 3 is | right-aligned | $1600 |
| col 2 is | centered | $12 |

#### 5.5. 目录
**输入**
```md
[[toc]]
```
目录的渲染可以通过`markdown.toc`选项来配置

#### 5.6. 自定义容器
自定义容器可以自定义它们的类型，标题和内容
**默认的标题**
**Input**
```md
::: tip
This is a tip
:::

::: warning
This is a warning
:::

::: danger
This is a dangerous warning
:::

::: details
This is a details block, which does not work in IE / Edge
:::
```
#### 5.7. 代码块高亮
VuePress使用[Prism](https://prismjs.com/)在Markdown代码块里使用带颜色的文本高亮编程语言语法。Prism支持大量的编程语言.对于代码块，你只需要在开头的倒引号后面追加编程语言的名称    
**Input**
```js
  ```js
  export default {
    name: 'MyComponent',
    // ...
  }
```

**Output**    
```js
export default {
  name: 'MyComponent'
}
```
#### 5.8. 代码块中的行高亮
**高亮第四行代码**
```
```js{4}
  export default {
    data () {
      return {
        msg: 'Highlighted!'
      }
    }
  }
```
除了单行，你也可以指定多个单行，范围或者两者都包含
- 行范围；例如：`{5-8}`,`{3-10}`,`{10-17}`
- 多个单行；例如：`{4.7.9}`\
- 行返回和单行；例如：`{4,7-18,16,23-27,40}`

#### 5.9. 行号
通过配置，你可以为每一行代码块启动行号
```js
module.exports = {
  markdown: {
    lineNumbers: true
  }
}
```

### 6、在Markdown中使用Vue
#### 6.1. 浏览器API访问限制
因为VuePress应用程序在生成静态构建时是在Node.js中服务端渲染的，任何Vue的使用者必须遵循通用代码编写规范。简而言之，确保仅在`beforeMount`或`mounted`钩子函数里访问浏览器/DOM的API.

如果你正在使用，或者需要展示一个对于SSR不怎么友好的组件（比如包含了自定义指令），你可以将它们包裹在内置的`<ClientOnly>`组件中：
```md
<ClientOnly>
  <NonSSRFriendlyComponent/>
</ClientOnly>
```    
注意这并没有修复组件或者库在被`import`的时候，访问浏览器api的限制；为了确保代码能够在`import`时访问到浏览器环境，你需要在正确的生命周期钩子中动态导入它们：    
```js
  <script>
    export default {
      mounted () {
        import('./lib-that-access-window-on-import').then(module => {
          // use code
        })
      }
    }
  </script>
```    

如果你的模块`export default`一个Vue组件，你可以动态注册它：    

```vue
<template>
  <component v-if="dynamicComponent" :is="dynamicComponent"></component>
</template>

<script>
export default {
  data () {
    return {
      dynamicComponent: null
    }
  },
  mounted () {
    import('./lib-that-access-window-on-import').then(module => {
      this.dynamicComponent = module.default
    })
  }
}
</script>
```
#### 6.2. 模板
##### 6.2.1. 插值
每一个Markdown文件，首先被编译成HTML，然后作为Vue组件传递给`vue-loader`.这意味着可以使用Vue风格的插值语法
```md
{{ 1 + 1 }}
```
##### 6.2.2. 指令
指令也可以工作
```md
<span v-for="i in 3">{{ i }}</span>
```    
##### 6.2.3. 访问网站和页面数据

编译后的组件没有任何私有数据，但是可以访问网站的 `元素据`和[网站全局属性](https://vuepress.vuejs.org/guide/global-computed.html#site 'computed properties')    

##### 6.2.4. 字符串逃逸
默认情况下，块级的代码块将会被自动包裹在`v-pre`中。如果你想要在内联（inline）的代码块或者普通文本中显示原始的大括号，或者一些Vue特定的语法，你需要使用自定义容器`v-pre`来包裹：    

**input**    
```md
::: v-pre
`{{ This will be displayed as-is }}`
```
**Output**    

`{{ This will be displayed as-is }}`

##### 6.2.5. 使用组件
所有在`.vuepress/components`中找到的`*.vue`文件将会自动地被注册为全局的异步组件，如：
```md
.
└─ .vuepress
   └─ components
      ├─ demo-1.vue
      ├─ OtherComponent.vue
      └─ Foo
         └─ Bar.vue
```
在任何Markdown文件里，你可以直接使用这个组件（组件名就是文件名）
```md
<demo-1/>
<OtherComponent/>
<Foo-Bar/>
```    
##### 6.2.6. 在Headers里面使用组件
可以在h标签里面使用Vue组件，但是注意下列语法的区别：
|Markdown|输出的html|解析后的h标签|
|------|------:|------:|
|# text </Tag>|<h1>text </Tag></h1>|`text`|
|# text `</Tag>`|`<h1>text <code>&lt;Tag/&gt;</code></h1>`|`text</Tag>`|

被`<code>`标签包裹的HTML将会按照原样显示；没有被`<code>`包裹的HTML标签将会被Vue解析

##### 6.2.7. 使用预处理器
VuePress内置了webpack支持的以下预处理器：`sass`,`scss`,`less`,`stylus`和`pug`.你只需要安装对应的依赖。例如，启用`sass`：    

```sh
yarn add -D sass-loader node-sass
```    
现在你可以在Markdown和主题组件里如下使用：

```vue
<style lang="sass">
.title
  font-size: 20px
</style>
```    

使用`<template lang="pug">`需要安装`pug`和`pug-plain-loader`:    

```sh
yarn add -D pug pug-plain-loader
```
> 如果你使用Stylus，不需要在项目中安装`stylus`和`stylus-loader`；VuePress内部就是使用的Stylus.
对于webpack不支持的预处理器，你需要[继承内部webpack配置](https://vuepress.vuejs.org/config/#less),同时安装必要的依赖.    

##### 6.2.8. 脚本和样式提取
有时，你可能只需要在当前页面应用js或者css。在这些情况下，你可以直接在Markdown文件中写根级别的`<script>`或者`<style>`块。这将会从已编译的html中提取出来，并作为生成的Vue单文件组件的`<script>`和`<style>`标签    

##### 6.2.9. 内置组件
**OutboundLink**
用于标记这是一个外部链接。这个组件应用在每一个外部链接上

**ClientOnly**
参考[Browser API Access Restrictions.](https://vuepress.vuejs.org/guide/using-vue.html#browser-api-access-restrictions)

**Content**
- **Props**
  - `pageKey` - 字符串，页面的hash键值，默认是当前页面的键值
  - `slotKey` - 字符串，[Markdown slot](https://vuepress.vuejs.org/guide/markdown-slot.html#why-do-i-need-markdown-slot).默认是[default slot](https://vuepress.vuejs.org/guide/markdown-slot.html#example)
- **Usage**
  为指定页面(.md)定义一个特定的slot用于渲染。当使用[自定义布局](https://vuepress.vuejs.org/theme/default-theme-config.html#custom-layout-for-specific-pages)或者[写一个主题](https://vuepress.vuejs.org/theme/writing-a-theme.html#content-outlet)时特别有用

  ```vue
  <Content/>
  ```




## 部署到github pages
1.cd src
2.打开git bash命令行工具，执行以下命令
```
sh deploy.sh
``` 
## VuePress特点
- Markdown为中心
- Vue驱动；可以在Markdown中使用Vue组件，也可以使用Vue来开发自定义主题
- 高性能；VuePress会为每个页面预渲染生成静态的HTML，同时，每个页面被加载的时候，将作为SPA运行。
