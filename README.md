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
