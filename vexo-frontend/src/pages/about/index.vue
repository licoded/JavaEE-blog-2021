<template>
    <div
        id="about-banner"
        style="background-image: url(https://ghimg.licoded.site/vexo/about-cover.jpeg)"
    ></div>
    <div class="author" style="margin-bottom: 117px;">
        <div class="head" style="transform: translateY(0px); opacity: 1;">
            <img src="https://ghimg.licoded.site/vexo/avator.jpeg" />
        </div>
        <h3 style="transform: translateY(0px); opacity: 1;">Licoded</h3>
        <p
            class="description"
            style="transform: translateY(0px); opacity: 1;"
        >Talk is cheap, show me the code!</p>
        <section class="share-icons" style="transform: translateY(0px); opacity: 1;">
            <a class="icon-github" href="https://github.com/Licoded" target="_blank">
                <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                </span>
            </a>
            <a class="icon-zhihu" href="https://www.zhihu.com/people/yummy1121" target="_blank">
                <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-stack-1x fa-inverse">知</i>
                </span>
            </a>
        </section>
    </div>
</template>
<style scoped>
#about-banner {
    width: 100%;
    position: relative;
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
    height: 350px;
}

#about-banner:after {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    content: "";
    opacity: 0.25;
    background: url("images/escheres.png");
    background-color: rgba(0, 0, 0, 0.05);
}

.author {
    margin-top: -50px;
    width: 100%;
    background: #f8f8f8;
    text-align: center;
    padding: 0 1em 30px 1em;
    box-sizing: border-box;
}

.author .head {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    padding: 3px;
    background: #fff;
    box-shadow: 0 0 5px #95a5a6;
    position: relative;
    margin: 0 auto;
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
}

.author .head img {
    width: 100%;
    height: 100%;
    display: block;
    border-radius: 50%;
}

.author h3 {
    font-size: 1.4em;
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
    transition-delay: 0.05s;
}

.author .description {
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
    transition-delay: 0.1s;
}

.author .share-icons {
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
    transition-delay: 0.15s;
    margin-top: 2em;
}

.author .share-icons a {
    font-size: 1em;
    display: inline-block;
    margin: 0 0.4em;
}

.author .share-icons a:hover {
    transition: opacity 0.2s;
    opacity: 0.6;
}

.author .share-icons .icon-weibo {
    color: #e6162d;
}
.author .share-icons .icon-github {
    color: #333333;
}
.author .share-icons .icon-linkedin {
    color: #0077b5;
}
.author .share-icons .icon-zhihu {
    color: #0767c8;
}
.author .share-icons .icon-twitter {
    color: #2aa9e0;
}
.author .share-icons .icon-douban {
    color: #00b51d;
}
</style>