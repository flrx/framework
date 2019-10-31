module.exports = {
    title: "Flrx Framework",
    description: "An opinionated redux framework",
    base: "/framework/",
    themeConfig: {
        displayAllHeaders: true,
        sidebar: [
        "/",
        "/page/",
        '/error-handling/',
        '/localization/',
        '/logging/',
        '/config/'
        ],
        nav: [
            {
                text: "Changelog",
                link: "https://github.com/flrx/framework/blob/master/CHANGELOG.md"
            },
            {
                text: "API Docs",
                link: "https://pub.dev/documentation/flrx_framework/latest/"
            },
        ],
        /* Repository Config */
        repo: "flrx/framework",
        repoLabel: "Github",
        docsDir: "doc",
        docsBranch: "master",
        editLinks: true,
        editLinkText: "Help us improve this page!"
    },
};
