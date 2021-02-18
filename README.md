# 使用vuepress搭建博客网站
## 使用[create-vuepress-site脚手架](https://github.com/vuepress/create-vuepress-site)创建vuepress网站的步骤
1. 执行命令`npx create-vuepress-site`
2. cd docs
3. npm install
4. npm run dev

## 目录说明
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

## 部署到github pages
1.cd src
2.打开git bash命令行工具，执行以下命令
```
sh deploy.sh
``` 
