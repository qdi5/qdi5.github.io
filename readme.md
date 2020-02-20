# jekyll生成博客网站

### 学习笔记
1. 以html,md,markdown结尾的文件，将会被作为一个页面存在，访问的时候，直接以根路径加上文件名访问，比如：contract.html,访问路径就是：https://qdi5.github.io/contract.html  
2. 使用`post_url`标签来跳转到其他文章，即使文章的永久链接更换了也不会有影响
3. 在文章中包含图片和文件等静态资源，可以在博客项目的根路径下新建一个文件夹，比如：assets,将静态资源文件如图片，pdf文件，等放在这个目录下，在文章中直接使用绝对路径引用;例如：[告白气球.mp3](/assets/media/renxi.mp3)
4. 草稿文章放在`_drafts`目录下
5. 包含在`---`里的内容，称作 Front Matter，在Front Matter里可以设置预定义变量，或自定义全局变量。这些变量可以在模板标签里面使用
6. 支持使用sass；文件需要以两行`---`开头
7. Layouts是包裹你的内容的模板文件。它们允许你在统一的地方，为你的模板存放源代码，因此你不必在每个页面都重复一些东西，像导航栏，页头，页脚等等。Layouts位于_layout目录下。按照约定有一个叫做`default.html`的基础模板,根据需要，也会有基于此模板的其他layouts.`content`是一个特殊的变量，它的值是layout包裹的post或page渲染之后的内容。
8. Pages构建内容的最基本单位，对于独立的内容非常有用；添加一个page的最简单方式就是在根目录添加一个html文件，并使用一个合适的文件名。也可以使用以.md后缀结尾的Markdown文件，在项目源代码被构建完成之后，它被转换为html文件。如果你的pages很多，你可以使用子目录来组织你的pages。
9. Posts是文章存放的地方，我们把博客文章写成文本文件（如markdown，html文件），jekyll会自动把它在系统中转换成一篇博客。在_posts文件夹下存放我们写的博客文章，文章文件的命名格式形如：`YEAR-MONTH-DAY-title.MARKUP`其中`MARKUP`可以是markdown或html；所有博客文章的内容，必须以`font matter`开头，用于设置`layout`或其他元信息，例如：
``` ruby  
  ---
  layout: post    
  title: "Welcome to Jekyll"
  ---
  # Welcome
  **hello world**, this is my first Jekyll blog post.
  I hope you like it!
```    
10.Front Matter:任何包含了`YAML`前言块的文件将会被Jekyll处理为一个特殊的文件。
11.Data Files。Jekyll支持从_data目录下的`YAML`,`JSON`,`CSV`和`TSV`文件加载数据。**CSV和TSV必须包含标题行**。目前暂不做深入了解，以后可以查看[这里](https://jekyllrb.com/docs/datafiles/ 'Jekyll Data Files说明文档')的文档。    
12.Permalinks固定链接。是`pages`，`posts`或`collections`的输出路径。它允许你组织你的源代码的目录结构和输出的目录结构不同。
