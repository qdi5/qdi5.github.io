# jekyll生成博客网站

### 学习笔记
1. 以html,md,markdown结尾的文件，将会被作为一个页面存在，访问的时候，直接以根路径加上文件名访问，比如：contract.html,访问路径就是：https://qdi5.github.io/contract.html  
2. 使用`post_url`标签来跳转到其他文章，即使文章的永久链接更换了也不会有影响
3. 在文章中包含图片和文件等静态资源，可以在博客项目的根路径下新建一个文件夹，比如：assets,将静态资源文件如图片，pdf文件，等放在这个目录下，在文章中直接使用绝对路径引用;例如：[告白气球.mp3](/assets/media/renxi.mp3)
4. 草稿文章放在`_drafts`目录下
5. 包含在`---`里的内容，称作 Front Matter，在Front Matter里可以设置预定义变量，或自定义全局变量。这些变量可以在模板标签里面使用
6. 支持使用sass；文件需要以两行`---`开头
7. Layouts是模板文件