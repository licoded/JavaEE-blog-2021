const commentList: Array<IComment> = [
  {
      "date": "2018-07-04",
      "msg": "非常靠谱的程序员",
      "uname": "犀利的评论家",
      "children": [
          {
              "id": 4,
              "uname": "夕阳红",
              "tname": "犀利的评论家",
              "date": "2018-07-06",
              "msg": "赞同，很靠谱，水平很高",
              "favors": 0,
              "avatar": "https://wx4.sinaimg.cn/mw690/69e273f8gy1ft1541dmb7j215o0qv7wh.jpg"
          },
          {
              "id": 5,
              "uname": "清晨一缕阳光",
              "tname": "夕阳红",
              "date": "2018-07-07",
              "msg": "大神一个！",
              "favors": 0,
              "avatar": "http://imgsrc.baidu.com/imgad/pic/item/c2fdfc039245d688fcba1b80aec27d1ed21b245d.jpg"
          }
      ],
      "id": 2,
      "favors": 3,
      "avatar": "http://ww4.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2pddjuj30v90uvagf.jpg"
  },
  {
      "date": "2018-07-04",
      "msg": "从没见过这么优秀的人",
      "uname": "毒蛇郭德纲",
      "children": [],
      "id": 6,
      "favors": 0,
      "avatar": "http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg"
  }
];

export const getComments = () => {
  return Promise.resolve(commentList);
};
