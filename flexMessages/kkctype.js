const line = require("@line/bot-sdk");

function createkkutypeFlexMessage() {
  return {
    type: "carousel",
    altText: "เลือกประเภทสถานที่",
    type: "flex",
      contents: {
        hero: {
          size: "full",
          aspectMode: "cover",
          action: {
            uri: "http://linecorp.com/",
            type: "uri",
          },
          type: "image",
          url: "https://github.com/cholthicha61/Picture/blob/main/13.png?raw=true",
          aspectRatio: "20:13",
        },
        type: "bubble",
        footer: {
          contents: [
            {
              type: "button",
              height: "sm",
              style: "primary",
              action: {
                type: "message",
                text: "แหล่งท่องเที่ยวทางธรรมชาติ",
                label: "แหล่งท่องเที่ยวทางธรรมชาติ",
              },
              color: "#3399FF",
            },
            {
              layout: "vertical",
              type: "box",
              contents: [],
              margin: "sm",
            },
            {
              layout: "vertical",
              type: "box",
              contents: [
                {
                  action: {
                    text: "แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก",
                    type: "message",
                    label: "แหล่งท่องเที่ยวสำหรับครอบครัวและเด็ก",
                  },
                  type: "button",
                  color: "#3399FF",
                  height: "sm",
                  style: "primary",
                },
                {
                  contents: [],
                  type: "box",
                  margin: "sm",
                  layout: "vertical",
                },
              ],
              spacing: "sm",
            },
            {
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  color: "#3399FF",
                  style: "primary",
                  action: {
                    label: "แหล่งท่องเที่ยวเพื่อนันทนาการ",
                    type: "message",
                    text: "แหล่งท่องเที่ยวเพื่อนันทนาการ",
                  },
                  height: "sm",
                  type: "button",
                },
                {
                  type: "box",
                  layout: "vertical",
                  margin: "sm",
                  contents: [],
                },
              ],
              type: "box",
            },
            {
              layout: "vertical",
              spacing: "sm",
              type: "box",
              contents: [
                {
                  color: "#3399FF",
                  type: "button",
                  style: "primary",
                  action: {
                    type: "message",
                    text: "แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์",
                    label: "แหล่งท่องเที่ยวทางวัฒนธรรมและประวัติศาสตร์",
                  },
                  height: "sm",
                },
                {
                  margin: "sm",
                  type: "box",
                  layout: "vertical",
                  contents: [],
                },
              ],
            },
            {
              type: "box",
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  type: "button",
                  style: "primary",
                  color: "#3399FF",
                  height: "sm",
                  action: {
                    type: "message",
                    label: "แหล่งท่องเที่ยวทางศาสนา",
                    text: "แหล่งท่องเที่ยวทางศาสนา",
                  },
                },
                {
                  margin: "sm",
                  layout: "vertical",
                  contents: [],
                  type: "box",
                },
              ],
            },
            {
              type: "box",
              layout: "vertical",
              spacing: "sm",
              contents: [
                {
                  style: "primary",
                  color: "#3399FF",
                  height: "sm",
                  type: "button",
                  action: {
                    label: "แหล่งท่องเที่ยวสำหรับช็อปปิ้ง",
                    type: "message",
                    text: "แหล่งท่องเที่ยวสำหรับช็อปปิ้ง",
                  },
                },
                {
                  contents: [],
                  layout: "vertical",
                  margin: "sm",
                  type: "box",
                },
              ],
            }
          ],
          layout: "vertical",
          spacing: "sm",
          type: "box",
        },
        body: {
          contents: [
            {
              text: "เลือกประเภทสถานที่",
              size: "xl",
              align: "start",
              contents: [],
              type: "text",
              color: "#000000FF",
              weight: "bold",
            },
            {
              type: "box",
              contents: [
                {
                  type: "box",
                  spacing: "sm",
                  contents: [],
                  layout: "baseline",
                },
              ],
              layout: "vertical",
              margin: "lg",
            },
            {
              margin: "lg",
              layout: "vertical",
              contents: [
                {
                  layout: "baseline",
                  contents: [
                    {
                      wrap: true,
                      color: "#5B5858FF",
                      type: "text",
                      contents: [],
                      text: "จิ้มด่างล่างได้เลย!!",
                      size: "xs",
                    },
                  ],
                  spacing: "sm",
                  type: "box",
                },
              ],
              spacing: "sm",
              type: "box",
            },
          ],
          layout: "vertical",
          type: "box",
        },
      },
  };
}

module.exports = {
  createkkutypeFlexMessage,
};
