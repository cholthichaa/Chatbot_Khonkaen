const { Payload } = require("dialogflow-fulfillment");

const sendTouristFlexMessage = (agent, questionText) => {
  if (!questionText || typeof questionText !== "string") {
    console.error("Error: questionText is undefined, null, or not a string.");
    agent.add("ขออภัย ไม่พบข้อมูลที่คุณต้องการ");
    return;
  }

  const flexMessages = {
    mountain: {
      altText: "เที่ยวภูเขา",
      type: "flex",
      contents: {
        type: "carousel",
        contents: [
          {
            type: "bubble",
            body: {
              type: "box",
              action: {
                text: "ป่าสนดงลาน",
                label: "ป่าสนดงลาน",
                type: "message",
              },
              layout: "vertical",
              contents: [
                {
                  weight: "bold",
                  size: "xl",
                  color: "#000000FF",
                  type: "text",
                  text: "ป่าสนดงลาน",
                  contents: [],
                  align: "start",
                },
                {
                  layout: "vertical",
                  margin: "lg",
                  spacing: "sm",
                  contents: [
                    {
                      layout: "baseline",
                      type: "box",
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          size: "md",
                          text: "ประเภท : ภูเขา",
                          type: "text",
                        },
                      ],
                      spacing: "sm",
                    },
                    {
                      spacing: "sm",
                      contents: [
                        {
                          type: "text",
                          color: "#5B5858FF",
                          size: "xs",
                          text: "ขอบคุณภาพจาก: FB: ไปเรื่อย ไปเปื่อย",
                          align: "start",
                          contents: [],
                        },
                      ],
                      layout: "baseline",
                      type: "box",
                    },
                  ],
                  type: "box",
                },
              ],
            },
            footer: {
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  style: "secondary",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    text: "รายละเอียดป่าสนดงลาน",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  color: "#FEFEFEFF",
                  type: "button",
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  height: "sm",
                  action: {
                    label: "เวลาทำการ",
                    text: "เวลาทำการป่าสนดงลาน",
                    type: "message",
                  },
                  type: "button",
                  style: "secondary",
                },
                {
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปป่าสนดงลาน",
                    type: "message",
                  },
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าป่าสนดงลาน",
                    type: "message",
                  },
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  type: "button",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              type: "box",
              spacing: "sm",
              layout: "vertical",
            },
            direction: "ltr",
            hero: {
              aspectMode: "cover",
              aspectRatio: "20:13",
              size: "full",
              type: "image",
              action: {
                type: "uri",
                uri: "https://linecorp.com/",
                label: "Line",
              },
              url: "https://i0.wp.com/www.lapakteaw.com/wp-content/uploads/2021/12/250299668_430952955255061_2587395881506505105_n.jpeg?ssl=1https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/DongLan2.jpg",
            },
          },
          {
            type: "bubble",
            body: {
              layout: "vertical",
              type: "box",
              action: {
                label: "จุดชมวิวหินช้างสี",
                text: "จุดชมวิวหินช้างสี",
                type: "message",
              },
              contents: [
                {
                  text: "จุดชมวิวหินช้างสี",
                  weight: "bold",
                  color: "#000000FF",
                  size: "xl",
                  align: "start",
                  type: "text",
                  contents: [],
                },
                {
                  type: "box",
                  spacing: "sm",
                  layout: "vertical",
                  margin: "lg",
                  contents: [
                    {
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          type: "text",
                          text: "ประเภท : ภูเขา",
                          color: "#5B5858FF",
                          size: "md",
                          contents: [],
                        },
                      ],
                    },
                    {
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: pukmodmuangthai",
                          contents: [],
                          size: "xs",
                          color: "#5B5858FF",
                          align: "start",
                          type: "text",
                        },
                      ],
                    },
                  ],
                },
              ],
            },
            direction: "ltr",
            footer: {
              spacing: "sm",
              contents: [
                {
                  type: "separator",
                  color: "#696969FF",
                  margin: "xl",
                },
                {
                  height: "sm",
                  style: "secondary",
                  type: "button",
                  action: {
                    text: "รายละเอียดจุดชมวิวหินช้างสี",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                },
                {
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการจุดชมวิวหินช้างสี",
                  },
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปป่าสนดงลาน",
                  },
                  height: "sm",
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  color: "#FFFFFFFF",
                },
                {
                  height: "sm",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  type: "button",
                  action: {
                    type: "message",
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าจุดชมวิวหินช้างสี",
                  },
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              layout: "vertical",
              type: "box",
            },
            hero: {
              aspectMode: "cover",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              type: "image",
              url: "https://pukmudmuangthai.com/wp-content/uploads/2022/05/kao02.jpg",
              size: "full",
              aspectRatio: "20:13",
            },
          },
          {
            type: "bubble",
            direction: "ltr",
            body: {
              layout: "vertical",
              action: {
                text: "ผาชมตะวัน",
                type: "message",
                label: "ผาชมตะวัน",
              },
              type: "box",
              contents: [
                {
                  weight: "bold",
                  text: "ผาชมตะวัน",
                  size: "xl",
                  contents: [],
                  color: "#000000FF",
                  type: "text",
                  align: "start",
                },
                {
                  margin: "lg",
                  contents: [
                    {
                      contents: [
                        {
                          size: "md",
                          text: "ประเภท : ภูเขา",
                          type: "text",
                          color: "#5B5858FF",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                      type: "box",
                    },
                    {
                      contents: [
                        {
                          align: "start",
                          type: "text",
                          size: "xs",
                          contents: [],
                          text: "ขอบคุณภาพจาก: เพจ ที่นี่ภูเวียง",
                          color: "#5B5858FF",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                      spacing: "sm",
                    },
                  ],
                  layout: "vertical",
                  type: "box",
                  spacing: "sm",
                },
              ],
            },
            hero: {
              type: "image",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              aspectMode: "cover",
              size: "full",
              aspectRatio: "20:13",
              url: "https://mpics.mgronline.com/pics/Images/563000010199301.JPEG",
            },
            footer: {
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  color: "#FEFEFEFF",
                  gravity: "bottom",
                  height: "sm",
                  type: "button",
                  action: {
                    text: "รายละเอียดผาชมตะวัน",
                    label: "รายละเอียด",
                    type: "message",
                  },
                  style: "secondary",
                },
                {
                  gravity: "bottom",
                  style: "secondary",
                  action: {
                    text: "เวลาทำการผาชมตะวัน",
                    label: "เวลาทำการ",
                    type: "message",
                  },
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปผาชมตะวัน",
                  },
                  height: "sm",
                  type: "button",
                  style: "secondary",
                },
                {
                  type: "button",
                  action: {
                    text: "ค่าเข้าผาชมตะวัน",
                    type: "message",
                    label: "ค่าเข้าชม",
                  },
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
            },
          },
          {
            body: {
              contents: [
                {
                  text: "น้ำตกตาดฟ้า",
                  type: "text",
                  contents: [],
                  color: "#000000FF",
                  weight: "bold",
                  align: "start",
                  size: "xl",
                },
                {
                  spacing: "sm",
                  type: "box",
                  margin: "lg",
                  layout: "vertical",
                  contents: [
                    {
                      type: "box",
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          text: "ประเภท : ภูเขา",
                          type: "text",
                          size: "md",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                    },
                    {
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          type: "text",
                          align: "start",
                          size: "xs",
                          contents: [],
                          text: "ขอบคุณภาพจาก: FB: Journey Directory",
                          color: "#5B5858FF",
                        },
                      ],
                    },
                  ],
                },
              ],
              type: "box",
              action: {
                type: "message",
                label: "น้ำตกตาดฟ้า",
                text: "น้ำตกตาดฟ้า",
              },
              layout: "vertical",
            },
            hero: {
              aspectRatio: "20:13",
              action: {
                type: "uri",
                uri: "https://linecorp.com/",
                label: "Line",
              },
              type: "image",
              aspectMode: "cover",
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/TatFah4.jpg",
              size: "full",
            },
            direction: "ltr",
            footer: {
              spacing: "sm",
              type: "box",
              layout: "vertical",
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                  height: "sm",
                  type: "button",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดน้ำตกตาดฟ้า",
                    type: "message",
                  },
                },
                {
                  gravity: "bottom",
                  type: "button",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการน้ำตกตาดฟ้า",
                  },
                  color: "#FFFFFFFF",
                  height: "sm",
                  style: "secondary",
                },
                {
                  color: "#FFFFFFFF",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    text: "เส้นทางไปน้ำตกตาดฟ้า",
                    type: "message",
                    label: "แผนที่",
                  },
                  style: "secondary",
                  type: "button",
                },
                {
                  style: "secondary",
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าน้ำตกตาดฟ้า",
                  },
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  type: "button",
                  height: "sm",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            type: "bubble",
          },
          {
            direction: "ltr",
            footer: {
              type: "box",
              layout: "vertical",
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  margin: "xl",
                  type: "separator",
                },
                {
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                  style: "secondary",
                  height: "sm",
                  type: "button",
                  action: {
                    text: "รายละเอียดน้ำตกบ๋าหลวง",
                    type: "message",
                    label: "รายละเอียด",
                  },
                },
                {
                  action: {
                    label: "เวลาทำการ",
                    text: "เวลาทำการน้ำตกบ๋าหลวง",
                    type: "message",
                  },
                  style: "secondary",
                  type: "button",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปน้ำตกบ๋าหลวง",
                  },
                  height: "sm",
                  color: "#FFFFFFFF",
                },
                {
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    type: "message",
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าน้ำตกบ๋าหลวง",
                  },
                  style: "secondary",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            body: {
              action: {
                type: "message",
                label: "น้ำตกบ๋าหลวง",
                text: "น้ำตกบ๋าหลวง",
              },
              layout: "vertical",
              type: "box",
              contents: [
                {
                  color: "#000000FF",
                  text: "น้ำตกบ๋าหลวง",
                  align: "start",
                  weight: "bold",
                  contents: [],
                  type: "text",
                  size: "xl",
                },
                {
                  layout: "vertical",
                  margin: "lg",
                  type: "box",
                  spacing: "sm",
                  contents: [
                    {
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          contents: [],
                          text: "ประเภท : ภูเขา",
                          color: "#5B5858FF",
                          type: "text",
                          size: "md",
                        },
                      ],
                      type: "box",
                    },
                    {
                      contents: [
                        {
                          color: "#5B5858FF",
                          type: "text",
                          align: "start",
                          text: "ขอบคุณภาพจาก: FB: ข่าว กระนวน KranuanNews",
                          contents: [],
                          size: "xs",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                      spacing: "sm",
                    },
                  ],
                },
              ],
            },
            type: "bubble",
            hero: {
              size: "full",
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/BaLuang2.jpg",
              type: "image",
              aspectRatio: "20:13",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectMode: "cover",
            },
          },
          {
            hero: {
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              url: "https://cms.dmpcdn.com/travel/2020/11/17/33efc790-28a1-11eb-a028-275648f720c6_original.jpg",
              type: "image",
              aspectMode: "cover",
              aspectRatio: "20:13",
              size: "full",
            },
            body: {
              contents: [
                {
                  color: "#000000FF",
                  contents: [],
                  text: "เขื่อนอุบลรัตน์",
                  align: "start",
                  type: "text",
                  weight: "bold",
                  size: "xl",
                },
                {
                  contents: [
                    {
                      layout: "baseline",
                      contents: [
                        {
                          color: "#5B5858FF",
                          size: "md",
                          contents: [],
                          text: "ประเภท : ภูเขา",
                          type: "text",
                        },
                      ],
                      type: "box",
                      spacing: "sm",
                    },
                    {
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          type: "text",
                          color: "#5B5858FF",
                          size: "xs",
                          contents: [],
                          text: "ขอบคุณภาพจาก : kwanchai/Shutterstock.com",
                          align: "start",
                        },
                      ],
                    },
                  ],
                  layout: "vertical",
                  margin: "lg",
                  spacing: "sm",
                  type: "box",
                },
              ],
              layout: "vertical",
              action: {
                type: "message",
                label: "เขื่อนอุบลรัตน์",
                text: "เขื่อนอุบลรัตน์",
              },
              type: "box",
            },
            footer: {
              layout: "vertical",
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  margin: "xl",
                  type: "separator",
                },
                {
                  style: "secondary",
                  action: {
                    text: "รายละเอียดเขื่อนอุบลรัตน์",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                },
                {
                  style: "secondary",
                  type: "button",
                  gravity: "bottom",
                  action: {
                    type: "message",
                    text: "เวลาทำการเขื่อนอุบลรัตน์",
                    label: "เวลาทำการ",
                  },
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  type: "button",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    type: "message",
                    label: "แผนที่",
                    text: "เส้นทางไปเขื่อนอุบลรัตน์",
                  },
                  height: "sm",
                },
                {
                  height: "sm",
                  style: "secondary",
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าเขื่อนอุบลรัตน์",
                  },
                  color: "#FFFFFFFF",
                  type: "button",
                  gravity: "bottom",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
            },
            direction: "ltr",
            type: "bubble",
          },
        ],
      },
    },
    zoo: {
      type: "flex",
      contents: {
        contents: [
          {
            footer: {
              layout: "vertical",
              type: "box",
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  action: {
                    type: "message",
                    text: "รายละเอียดเอ็กโซติค",
                    label: "รายละเอียด",
                  },
                  style: "secondary",
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                },
                {
                  height: "sm",
                  gravity: "bottom",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เวลาทำการเอ็กโซติค",
                    label: "เวลาทำการ",
                  },
                  type: "button",
                  color: "#FFFFFFFF",
                },
                {
                  color: "#FFFFFFFF",
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                  action: {
                    type: "message",
                    text: "เส้นทางไปเอ็กโซติค",
                    label: "แผนที่",
                  },
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  type: "button",
                  style: "secondary",
                  height: "sm",
                  action: {
                    type: "message",
                    text: "ค่าเข้าเอ็กโซติค",
                    label: "ค่าเข้าชม",
                  },
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              spacing: "sm",
            },
            body: {
              layout: "vertical",
              type: "box",
              action: {
                label: "เอ็กโซติค",
                text: "เอ็กโซติค",
                type: "message",
              },
              contents: [
                {
                  contents: [],
                  type: "text",
                  size: "xl",
                  text: "เอ็กโซติค",
                  align: "start",
                  weight: "bold",
                  color: "#000000FF",
                },
                {
                  margin: "lg",
                  layout: "vertical",
                  type: "box",
                  spacing: "sm",
                  contents: [
                    {
                      layout: "baseline",
                      type: "box",
                      contents: [
                        {
                          type: "text",
                          color: "#5B5858FF",
                          contents: [],
                          size: "md",
                          text: "ประเภท : สวนสัตว์",
                        },
                      ],
                      spacing: "sm",
                    },
                    {
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          contents: [],
                          size: "xs",
                          align: "start",
                          type: "text",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก: mickey.msk ",
                        },
                      ],
                    },
                  ],
                },
              ],
            },
            direction: "ltr",
            hero: {
              aspectRatio: "20:13",
              size: "full",
              url: "https://img.wongnai.com/p/1920x0/2022/04/19/ee9f053cba4e456693554f0fdd5f23d6.jpg",
              type: "image",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectMode: "cover",
            },
            type: "bubble",
          },
          {
            body: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  align: "start",
                  color: "#000000FF",
                  contents: [],
                  size: "xl",
                  weight: "bold",
                  type: "text",
                  text: "สวนสัตว์ขอนแก่น",
                },
                {
                  contents: [
                    {
                      layout: "baseline",
                      contents: [
                        {
                          text: "ประเภท : สวนสัตว์",
                          size: "md",
                          color: "#5B5858FF",
                          type: "text",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                      type: "box",
                    },
                    {
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          size: "xs",
                          align: "start",
                          text: "ขอบคุณภาพจาก: เว็บไซต์ thailandtourismdirectory",
                          type: "text",
                        },
                      ],
                    },
                  ],
                  margin: "lg",
                  spacing: "sm",
                  layout: "vertical",
                  type: "box",
                },
              ],
              action: {
                type: "message",
                label: "สวนสัตว์ขอนแก่น",
                text: "สวนสัตว์ขอนแก่น",
              },
            },
            footer: {
              type: "box",
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  style: "secondary",
                  action: {
                    text: "รายละเอียดสวนสัตว์ขอนแก่น",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  height: "sm",
                  type: "button",
                  color: "#FEFEFEFF",
                  gravity: "bottom",
                },
                {
                  color: "#FFFFFFFF",
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการสวนสัตว์ขอนแก่น",
                  },
                },
                {
                  type: "button",
                  height: "sm",
                  action: {
                    text: "เส้นทางไปสวนสัตว์ขอนแก่น",
                    label: "แผนที่",
                    type: "message",
                  },
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าสวนสัตว์ขอนแก่น",
                  },
                  color: "#FFFFFFFF",
                  height: "sm",
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              layout: "vertical",
            },
            direction: "ltr",
            hero: {
              size: "full",
              action: {
                type: "uri",
                uri: "https://linecorp.com/",
                label: "Line",
              },
              aspectMode: "cover",
              aspectRatio: "20:13",
              type: "image",
              url: "https://files.thailandtourismdirectory.go.th/assets/upload/2018/03/28/20180328362e15255957ca1d9fa25686618333a3140327.jpg",
            },
            type: "bubble",
          },
        ],
        type: "carousel",
      },
      altText: "ไปเที่ยวสวนสัตว์ไหนดี",
    },
    national: {
      type: "flex",
      altText: "อุทยานแห่งชาติ",
      contents: {
        type: "carousel",
        contents: [
          {
            type: "bubble",
            body: {
              layout: "vertical",
              contents: [
                {
                  text: "อุทยานแห่งชาติภูผาม่าน",
                  color: "#000000FF",
                  contents: [],
                  type: "text",
                  align: "start",
                  size: "xl",
                  weight: "bold",
                },
                {
                  type: "box",
                  layout: "vertical",
                  spacing: "sm",
                  margin: "lg",
                  contents: [
                    {
                      contents: [
                        {
                          size: "md",
                          contents: [],
                          text: "ประเภท : อุทยานแห่งชาติ",
                          color: "#5B5858FF",
                          type: "text",
                        },
                      ],
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: FB: อุทยานแห่งชาติภูผาม่าน - Phuphaman National Park",
                          contents: [],
                          align: "start",
                          type: "text",
                          color: "#5B5858FF",
                          size: "xs",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                    },
                  ],
                },
              ],
              action: {
                type: "message",
                label: "อุทยานแห่งชาติภูผาม่าน",
                text: "อุทยานแห่งชาติภูผาม่าน",
              },
              type: "box",
            },
            footer: {
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  type: "button",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดอุทยานแห่งชาติภูผาม่าน",
                    type: "message",
                  },
                  gravity: "bottom",
                  height: "sm",
                  color: "#FEFEFEFF",
                },
                {
                  action: {
                    text: "เวลาทำการอุทยานแห่งชาติภูผาม่าน",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  action: {
                    text: "เส้นทางไปอุทยานแห่งชาติภูผาม่าน",
                    label: "แผนที่",
                    type: "message",
                  },
                  type: "button",
                  height: "sm",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  height: "sm",
                  style: "secondary",
                  type: "button",
                  action: {
                    text: "ค่าเข้าอุทยานแห่งชาติภูผาม่าน",
                    type: "message",
                    label: "ค่าเข้าชม",
                  },
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              spacing: "sm",
              layout: "vertical",
              type: "box",
            },
            direction: "ltr",
            hero: {
              action: {
                type: "uri",
                label: "Line",
                uri: "https://linecorp.com/",
              },
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/PhuPhaManNationalPark1.jpg",
              type: "image",
              aspectRatio: "20:13",
              aspectMode: "cover",
              size: "full",
            },
          },
          {
            footer: {
              layout: "vertical",
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  gravity: "bottom",
                  style: "secondary",
                  height: "sm",
                  color: "#FEFEFEFF",
                  type: "button",
                  action: {
                    text: "รายละเอียดอุทยานแห่งชาติน้ำพอง",
                    label: "รายละเอียด",
                    type: "message",
                  },
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  height: "sm",
                  action: {
                    type: "message",
                    text: "เวลาทำการอุทยานแห่งชาติน้ำพอง",
                    label: "เวลาทำการ",
                  },
                  type: "button",
                },
                {
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปอุทยานแห่งชาติน้ำพอง",
                  },
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                  color: "#FFFFFFFF",
                },
                {
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าอุทยานแห่งชาติน้ำพอง",
                    type: "message",
                  },
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
              spacing: "sm",
            },
            type: "bubble",
            direction: "ltr",
            hero: {
              type: "image",
              url: "https://s.isanook.com/tr/0/ui/283/1418945/20e10ede6809ee364e1d36c47ad1da4d_1578661117.jpg",
              aspectRatio: "20:13",
              action: {
                type: "uri",
                label: "Line",
                uri: "https://linecorp.com/",
              },
              aspectMode: "cover",
              size: "full",
            },
            body: {
              contents: [
                {
                  contents: [],
                  color: "#000000FF",
                  type: "text",
                  weight: "bold",
                  align: "start",
                  text: "อุทยานแห่งชาติน้ำพอง",
                  size: "xl",
                },
                {
                  margin: "lg",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          text: "ประเภท : อุทยานแห่งชาติ",
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                          size: "md",
                        },
                      ],
                    },
                    {
                      contents: [
                        {
                          align: "start",
                          contents: [],
                          color: "#5B5858FF",
                          size: "xs",
                          text: "ขอบคุณภาพจาก: sanook",
                          type: "text",
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                    },
                  ],
                  type: "box",
                  spacing: "sm",
                  layout: "vertical",
                },
              ],
              action: {
                text: "อุทยานแห่งชาติน้ำพอง",
                type: "message",
                label: "อุทยานแห่งชาติน้ำพอง",
              },
              type: "box",
              layout: "vertical",
            },
          },
          {
            body: {
              layout: "vertical",
              type: "box",
              contents: [
                {
                  text: "อุทยานแห่งชาติภูเวียง",
                  color: "#000000FF",
                  contents: [],
                  weight: "bold",
                  size: "xl",
                  type: "text",
                  align: "start",
                },
                {
                  type: "box",
                  contents: [
                    {
                      layout: "baseline",
                      contents: [
                        {
                          color: "#5B5858FF",
                          size: "md",
                          contents: [],
                          type: "text",
                          text: "ประเภท : อุทยานแห่งชาติ",
                        },
                      ],
                      type: "box",
                      spacing: "sm",
                    },
                    {
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: FB: อุทยานแห่งชาติภูเวียง - Phu Wiang National Park",
                          type: "text",
                          color: "#5B5858FF",
                          size: "xs",
                          contents: [],
                          align: "start",
                        },
                      ],
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                    },
                  ],
                  margin: "lg",
                  layout: "vertical",
                  spacing: "sm",
                },
              ],
              action: {
                type: "message",
                text: "อุทยานแห่งชาติภูเวียง",
                label: "อุทยานแห่งชาติภูเวียง",
              },
            },
            footer: {
              type: "box",
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                  color: "#FEFEFEFF",
                  action: {
                    text: "รายละเอียดอุทยานแห่งชาติภูเวียง",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  style: "secondary",
                },
                {
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    text: "เวลาทำการอุทยานแห่งชาติภูเวียง",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                },
                {
                  color: "#FFFFFFFF",
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปอุทยานแห่งชาติภูเวียง",
                    type: "message",
                  },
                },
                {
                  gravity: "bottom",
                  style: "secondary",
                  type: "button",
                  color: "#FFFFFFFF",
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าอุทยานแห่งชาติภูเวียง",
                  },
                  height: "sm",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            direction: "ltr",
            hero: {
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/PhuWiangNationalPark1.jpg",
              size: "full",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              aspectMode: "cover",
              aspectRatio: "20:13",
              type: "image",
            },
            type: "bubble",
          },
        ],
      },
    },
    museum: {
      contents: {
        contents: [
          {
            direction: "ltr",
            body: {
              layout: "vertical",
              action: {
                text: "พิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                type: "message",
                label: "พิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
              },
              contents: [
                {
                  text: "พิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                  weight: "bold",
                  contents: [],
                  align: "start",
                  size: "xl",
                  color: "#000000FF",
                  type: "text",
                },
                {
                  spacing: "sm",
                  layout: "vertical",
                  type: "box",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          size: "md",
                          type: "text",
                          text: "ประเภท : พิพิธภัณฑ์",
                          contents: [],
                          color: "#5B5858FF",
                        },
                      ],
                      layout: "baseline",
                    },
                    {
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: TASTE-TEST",
                          size: "xs",
                          color: "#5B5858FF",
                          align: "start",
                          contents: [],
                          type: "text",
                        },
                      ],
                      type: "box",
                    },
                  ],
                  margin: "lg",
                },
              ],
              type: "box",
            },
            hero: {
              url: "https://img.wongnai.com/p/1920x0/2019/08/31/2493edf8ab78412a806bce1eb7b240a5.jpg",
              size: "full",
              action: {
                label: "Line",
                type: "uri",
                uri: "https://linecorp.com/",
              },
              type: "image",
              aspectRatio: "20:13",
              aspectMode: "cover",
            },
            type: "bubble",
            footer: {
              layout: "vertical",
              spacing: "sm",
              type: "box",
              contents: [
                {
                  type: "separator",
                  color: "#696969FF",
                  margin: "xl",
                },
                {
                  color: "#FEFEFEFF",
                  type: "button",
                  action: {
                    text: "รายละเอียดพิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  height: "sm",
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  gravity: "bottom",
                  type: "button",
                  style: "secondary",
                  height: "sm",
                  color: "#FFFFFFFF",
                  action: {
                    label: "เวลาทำการ",
                    type: "message",
                    text: "เวลาทำการพิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                  },
                },
                {
                  action: {
                    text: "เส้นทางไปพิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                    type: "message",
                    label: "แผนที่",
                  },
                  height: "sm",
                  color: "#FFFFFFFF",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  style: "secondary",
                  action: {
                    text: "ค่าเข้าพิพิธภัณฑ์ไดโนเสาร์ภูเวียง",
                    type: "message",
                    label: "ค่าเข้าชม",
                  },
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
          },
          {
            footer: {
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  margin: "xl",
                  type: "separator",
                },
                {
                  style: "secondary",
                  height: "sm",
                  color: "#FEFEFEFF",
                  type: "button",
                  action: {
                    text: "รายละเอียดปราสาทเปือยน้อย",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  gravity: "bottom",
                },
                {
                  style: "secondary",
                  gravity: "bottom",
                  action: {
                    text: "เวลาทำการปราสาทเปือยน้อย",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                  type: "button",
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  type: "button",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  action: {
                    text: "เส้นทางไปปราสาทเปือยน้อย",
                    label: "แผนที่",
                    type: "message",
                  },
                  height: "sm",
                  gravity: "bottom",
                },
                {
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าปราสาทเปือยน้อย",
                    type: "message",
                  },
                  type: "button",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              layout: "vertical",
              type: "box",
            },
            type: "bubble",
            hero: {
              url: "https://f.ptcdn.info/282/056/000/p4i9t7a6rZG5WGzX2o1-o.jpg",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectRatio: "20:13",
              aspectMode: "cover",
              size: "full",
              type: "image",
            },
            body: {
              layout: "vertical",
              action: {
                label: "ปราสาทเปือยน้อย",
                type: "message",
                text: "ปราสาทเปือยน้อย",
              },
              contents: [
                {
                  size: "xl",
                  weight: "bold",
                  type: "text",
                  align: "start",
                  text: "ปราสาทเปือยน้อย",
                  contents: [],
                  color: "#000000FF",
                },
                {
                  contents: [
                    {
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          text: "ประเภท : พิพิธภัณฑ์",
                          size: "md",
                          type: "text",
                          contents: [],
                          color: "#5B5858FF",
                        },
                      ],
                    },
                    {
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: จิมมี่ พาตะลอน",
                          color: "#5B5858FF",
                          contents: [],
                          size: "xs",
                          align: "start",
                          type: "text",
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                    },
                  ],
                  spacing: "sm",
                  type: "box",
                  margin: "lg",
                  layout: "vertical",
                },
              ],
              type: "box",
            },
            direction: "ltr",
          },
        ],
        type: "carousel",
      },
      altText: "พิพิธภัณฑ์",
      type: "flex",
    },
    water: {
      contents: {
        type: "carousel",
        contents: [
          {
            body: {
              contents: [
                {
                  type: "text",
                  align: "start",
                  weight: "bold",
                  text: "สวนน้ำไดโนวอเตอร์ปาร์ค",
                  contents: [],
                  size: "xl",
                  color: "#000000FF",
                },
                {
                  type: "box",
                  spacing: "sm",
                  margin: "lg",
                  layout: "vertical",
                  contents: [
                    {
                      contents: [
                        {
                          type: "text",
                          contents: [],
                          text: "ประเภท : สวนน้ำ",
                          size: "md",
                          color: "#5B5858FF",
                        },
                      ],
                      spacing: "sm",
                      type: "box",
                      layout: "baseline",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          align: "start",
                          contents: [],
                          size: "xs",
                          type: "text",
                          text: "ขอบคุณภาพจาก: เพจ Hi-End Dino Water Park",
                          color: "#5B5858FF",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                    },
                  ],
                },
              ],
              layout: "vertical",
              type: "box",
              action: {
                label: "สวนน้ำไดโนวอเตอร์ปาร์ค",
                type: "message",
                text: "สวนน้ำไดโนวอเตอร์ปาร์ค",
              },
            },
            hero: {
              aspectRatio: "20:13",
              url: "https://img.kapook.com/u/2015/panadda/Travel1/Dino%20Water%20Park3.jpg",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              type: "image",
              size: "full",
              aspectMode: "cover",
            },
            footer: {
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  type: "button",
                  color: "#FEFEFEFF",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดสวนน้ำไดโนวอเตอร์ปาร์ค",
                    type: "message",
                  },
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  action: {
                    text: "เวลาทำการสวนน้ำไดโนวอเตอร์ปาร์ค",
                    label: "เวลาทำการ",
                    type: "message",
                  },
                  color: "#FFFFFFFF",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  height: "sm",
                },
                {
                  height: "sm",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เส้นทางไปสวนน้ำไดโนวอเตอร์ปาร์ค",
                    label: "แผนที่",
                  },
                  type: "button",
                },
                {
                  type: "button",
                  style: "secondary",
                  action: {
                    text: "ค่าเข้าสวนน้ำไดโนวอเตอร์ปาร์ค",
                    label: "ค่าเข้าชม",
                    type: "message",
                  },
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              type: "box",
              spacing: "sm",
              layout: "vertical",
            },
            direction: "ltr",
            type: "bubble",
          },
          {
            body: {
              type: "box",
              action: {
                type: "message",
                text: "สวนน้ำสวนสัตว์ขอนแก่น",
                label: "สวนน้ำสวนสัตว์ขอนแก่น",
              },
              layout: "vertical",
              contents: [
                {
                  align: "start",
                  type: "text",
                  weight: "bold",
                  contents: [],
                  text: "สวนน้ำสวนสัตว์ขอนแก่น",
                  color: "#000000FF",
                  size: "xl",
                },
                {
                  contents: [
                    {
                      contents: [
                        {
                          type: "text",
                          size: "md",
                          color: "#5B5858FF",
                          contents: [],
                          text: "ประเภท : สวนน้ำ",
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                    },
                    {
                      spacing: "sm",
                      type: "box",
                      layout: "baseline",
                      contents: [
                        {
                          color: "#5B5858FF",
                          align: "start",
                          contents: [],
                          type: "text",
                          size: "xs",
                          text: "ขอบคุณภาพจาก: เพจ สวนสัตว์ขอนแก่น khonkaen zoo",
                        },
                      ],
                    },
                  ],
                  margin: "lg",
                  layout: "vertical",
                  spacing: "sm",
                  type: "box",
                },
              ],
            },
            hero: {
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectRatio: "20:13",
              aspectMode: "cover",
              type: "image",
              size: "full",
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/ZooWaterPark1.jpg",
            },
            direction: "ltr",
            footer: {
              layout: "vertical",
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                  height: "sm",
                  style: "secondary",
                  type: "button",
                  action: {
                    type: "message",
                    text: "รายละเอียดสวนน้ำสวนสัตว์ขอนแก่น",
                    label: "รายละเอียด",
                  },
                },
                {
                  height: "sm",
                  color: "#FFFFFFFF",
                  type: "button",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการสวนน้ำสวนสัตว์ขอนแก่น",
                  },
                  style: "secondary",
                  gravity: "bottom",
                },
                {
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เส้นทางไปสวนน้ำสวนสัตว์ขอนแก่น",
                    label: "แผนที่",
                  },
                },
                {
                  height: "sm",
                  color: "#FFFFFFFF",
                  type: "button",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "ค่าเข้าสวนน้ำสวนสัตว์ขอนแก่น",
                    label: "ค่าเข้าชม",
                  },
                  gravity: "bottom",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
              spacing: "sm",
            },
            type: "bubble",
          },
          {
            type: "bubble",
            direction: "ltr",
            footer: {
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  style: "secondary",
                  action: {
                    type: "message",
                    label: "รายละเอียด",
                    text: "รายละเอียดบางแสน 2",
                  },
                  color: "#FEFEFEFF",
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                },
                {
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  height: "sm",
                  color: "#FFFFFFFF",
                  action: {
                    text: "เวลาทำการบางแสน 2",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                },
                {
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปบางแสน 2",
                  },
                  color: "#FFFFFFFF",
                  style: "secondary",
                },
                {
                  action: {
                    text: "ค่าเข้าบางแสน 2",
                    label: "ค่าเข้าชม",
                    type: "message",
                  },
                  color: "#FFFFFFFF",
                  style: "secondary",
                  type: "button",
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
            },
            body: {
              action: {
                label: "บางแสน 2",
                type: "message",
                text: "บางแสน 2",
              },
              layout: "vertical",
              contents: [
                {
                  type: "text",
                  weight: "bold",
                  color: "#000000FF",
                  text: "บางแสน 2",
                  size: "xl",
                  align: "start",
                  contents: [],
                },
                {
                  type: "box",
                  margin: "lg",
                  contents: [
                    {
                      contents: [
                        {
                          color: "#5B5858FF",
                          size: "md",
                          contents: [],
                          text: "ประเภท : สวนน้ำ",
                          type: "text",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                      spacing: "sm",
                    },
                    {
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          size: "xs",
                          text: "ขอบคุณภาพจาก: เว็บไซต์ thailandtourismdirectory",
                          contents: [],
                          color: "#5B5858FF",
                          type: "text",
                          align: "start",
                        },
                      ],
                    },
                  ],
                  layout: "vertical",
                  spacing: "sm",
                },
              ],
              type: "box",
            },
            hero: {
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              size: "full",
              aspectMode: "cover",
              type: "image",
              aspectRatio: "20:13",
              url: "https://files.thailandtourismdirectory.go.th/assets/upload/2018/03/28/2018032819673cb778f80d7bb206a7916713b039132323.jpg",
            },
          },
        ],
      },
      altText: "สวนน้ำ",
      type: "flex",
    },
    park: {
      contents: {
        type: "carousel",
        contents: [
          {
            type: "bubble",
            direction: "ltr",
            body: {
              contents: [
                {
                  weight: "bold",
                  size: "xl",
                  contents: [],
                  align: "start",
                  color: "#000000FF",
                  type: "text",
                  text: "บึงทุ่งสร้าง",
                },
                {
                  type: "box",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          type: "text",
                          color: "#5B5858FF",
                          size: "md",
                          contents: [],
                          text: "ประเภท : สวนสาธารณะ",
                        },
                      ],
                      layout: "baseline",
                    },
                    {
                      spacing: "sm",
                      contents: [
                        {
                          size: "xs",
                          text: "ขอบคุณภาพจาก: เพจ Khon Kaen City ขอนแก่นซิตี้",
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                          align: "start",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                    },
                  ],
                  margin: "lg",
                  spacing: "sm",
                  layout: "vertical",
                },
              ],
              type: "box",
              layout: "vertical",
              action: {
                type: "message",
                label: "บึงทุ่งสร้าง",
                text: "บึงทุ่งสร้าง",
              },
            },
            hero: {
              url: "https://f.ptcdn.info/147/077/000/rb8djdh74IdYPXM5sh3-o.jpg",
              aspectRatio: "20:13",
              size: "full",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectMode: "cover",
              type: "image",
            },
            footer: {
              spacing: "sm",
              layout: "vertical",
              type: "box",
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  action: {
                    label: "รายละเอียด",
                    type: "message",
                    text: "รายละเอียดบึงทุ่งสร้าง",
                  },
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                  color: "#FEFEFEFF",
                  style: "secondary",
                },
                {
                  height: "sm",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  action: {
                    text: "เวลาทำการบึงทุ่งสร้าง",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                  type: "button",
                  gravity: "bottom",
                },
                {
                  type: "button",
                  action: {
                    type: "message",
                    text: "เส้นทางไปบึงทุ่งสร้าง",
                    label: "แผนที่",
                  },
                  color: "#FFFFFFFF",
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  style: "secondary",
                  type: "button",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  height: "sm",
                  action: {
                    type: "message",
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าบึงทุ่งสร้าง",
                  },
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
          },
          {
            type: "bubble",
            direction: "ltr",
            body: {
              layout: "vertical",
              type: "box",
              contents: [
                {
                  align: "start",
                  weight: "bold",
                  size: "xl",
                  type: "text",
                  contents: [],
                  color: "#000000FF",
                  text: "บึงสีฐาน",
                },
                {
                  spacing: "sm",
                  margin: "lg",
                  layout: "vertical",
                  type: "box",
                  contents: [
                    {
                      layout: "baseline",
                      contents: [
                        {
                          color: "#5B5858FF",
                          text: "ประเภท : สวนสาธารณะ",
                          size: "md",
                          type: "text",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                      type: "box",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          align: "start",
                          size: "xs",
                          text: "ขอบคุณภาพจาก: relaxplacekku",
                          type: "text",
                          color: "#5B5858FF",
                          contents: [],
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                    },
                  ],
                },
              ],
              action: {
                label: "บึงสีฐาน",
                type: "message",
                text: "บึงสีฐาน",
              },
            },
            hero: {
              size: "full",
              aspectMode: "cover",
              type: "image",
              url: "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEg_Ock7Oa4GIWAmeAtWnaU7fhTVm-ymw2AYs21B75LIhtnhtZ8zzjHp-1rdxkzFD8vs1sOXu5rPlXeYtzVD0ur6Daxl4joCiNwJstNEE3HWcF3HorEZZYZ9sF7NLQDqNazt8zJ2_Q9DcSfL/s1600/C360_2014-11-14-17-58-59-324.jpg",
              action: {
                uri: "https://linecorp.com/",
                type: "uri",
                label: "Line",
              },
              aspectRatio: "20:13",
            },
            footer: {
              contents: [
                {
                  margin: "xl",
                  color: "#696969FF",
                  type: "separator",
                },
                {
                  type: "button",
                  color: "#FEFEFEFF",
                  height: "sm",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    type: "message",
                    text: "รายละเอียดบึงสีฐาน",
                  },
                  gravity: "bottom",
                },
                {
                  type: "button",
                  style: "secondary",
                  height: "sm",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการบึงสีฐาน",
                  },
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                },
                {
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เส้นทางไปบึงสีฐาน",
                    label: "แผนที่",
                  },
                  color: "#FFFFFFFF",
                },
                {
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าบึงสีฐาน",
                    type: "message",
                  },
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              spacing: "sm",
              type: "box",
              layout: "vertical",
            },
          },
          {
            body: {
              layout: "vertical",
              action: {
                type: "message",
                label: "บึงแก่นนคร",
                text: "บึงแก่นนคร",
              },
              contents: [
                {
                  contents: [],
                  text: "บึงแก่นนคร",
                  weight: "bold",
                  type: "text",
                  size: "xl",
                  align: "start",
                  color: "#000000FF",
                },
                {
                  type: "box",
                  margin: "lg",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                          size: "md",
                          text: "ประเภท : สวนสาธารณะ",
                        },
                      ],
                    },
                    {
                      spacing: "sm",
                      contents: [
                        {
                          contents: [],
                          align: "start",
                          type: "text",
                          size: "xs",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก: เว็บไซต์ khonkaenlink",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                    },
                  ],
                  spacing: "sm",
                  layout: "vertical",
                },
              ],
              type: "box",
            },
            footer: {
              type: "box",
              layout: "vertical",
              contents: [
                {
                  color: "#696969FF",
                  margin: "xl",
                  type: "separator",
                },
                {
                  action: {
                    text: "รายละเอียดบึงแก่นนคร",
                    label: "รายละเอียด",
                    type: "message",
                  },
                  height: "sm",
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  color: "#FEFEFEFF",
                },
                {
                  gravity: "bottom",
                  action: {
                    label: "เวลาทำการ",
                    type: "message",
                    text: "เวลาทำการบึงแก่นนคร",
                  },
                  height: "sm",
                  type: "button",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  height: "sm",
                  action: {
                    text: "เส้นทางไปบึงแก่นนคร",
                    type: "message",
                    label: "แผนที่",
                  },
                  gravity: "bottom",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  type: "button",
                },
                {
                  type: "button",
                  style: "secondary",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าบึงแก่นนคร",
                  },
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              spacing: "sm",
            },
            hero: {
              aspectMode: "cover",
              type: "image",
              aspectRatio: "20:13",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              size: "full",
              url: "https://old.khonkaenlink.info/home/upload/photo/news/gkg6jnCr.jpg",
            },
            direction: "ltr",
            type: "bubble",
          },
        ],
      },
      type: "flex",
      altText: "สวนสาธารณะ",
    },
    temple: {
      altText: "วัด",
      type: "flex",
      contents: {
        contents: [
          {
            type: "bubble",
            footer: {
              type: "box",
              layout: "vertical",
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  margin: "xl",
                  type: "separator",
                },
                {
                  style: "secondary",
                  type: "button",
                  action: {
                    label: "รายละเอียด",
                    type: "message",
                    text: "รายละเอียดพระมหาธาตุแก่นนคร",
                  },
                  height: "sm",
                  color: "#FEFEFEFF",
                  gravity: "bottom",
                },
                {
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                  action: {
                    text: "เวลาทำการพระมหาธาตุแก่นนคร",
                    label: "เวลาทำการ",
                    type: "message",
                  },
                  color: "#FFFFFFFF",
                },
                {
                  color: "#FFFFFFFF",
                  type: "button",
                  height: "sm",
                  action: {
                    type: "message",
                    text: "เส้นทางไปพระมหาธาตุแก่นนคร",
                    label: "แผนที่",
                  },
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  color: "#FFFFFFFF",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  height: "sm",
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าพระมหาธาตุแก่นนคร",
                    type: "message",
                  },
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
            },
            direction: "ltr",
            body: {
              type: "box",
              action: {
                type: "message",
                label: "พระมหาธาตุแก่นนคร",
                text: "พระมหาธาตุแก่นนคร",
              },
              contents: [
                {
                  align: "start",
                  weight: "bold",
                  type: "text",
                  size: "xl",
                  color: "#000000FF",
                  contents: [],
                  text: "พระมหาธาตุแก่นนคร",
                },
                {
                  margin: "lg",
                  layout: "vertical",
                  type: "box",
                  contents: [
                    {
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          text: "ประเภท : วัด",
                          contents: [],
                          size: "md",
                          color: "#5B5858FF",
                          type: "text",
                        },
                      ],
                    },
                    {
                      layout: "baseline",
                      contents: [
                        {
                          contents: [],
                          size: "xs",
                          type: "text",
                          align: "start",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก: FB: Story of Esan",
                        },
                      ],
                      type: "box",
                      spacing: "sm",
                    },
                  ],
                  spacing: "sm",
                },
              ],
              layout: "vertical",
            },
            hero: {
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/NongWaeng2.jpg",
              size: "full",
              aspectRatio: "20:13",
              aspectMode: "cover",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              type: "image",
            },
          },
          {
            body: {
              layout: "vertical",
              contents: [
                {
                  size: "xl",
                  type: "text",
                  color: "#000000FF",
                  weight: "bold",
                  text: "ศาลหลักเมือง",
                  align: "start",
                  contents: [],
                },
                {
                  margin: "lg",
                  spacing: "sm",
                  contents: [
                    {
                      layout: "baseline",
                      type: "box",
                      contents: [
                        {
                          color: "#5B5858FF",
                          text: "ประเภท : วัด",
                          type: "text",
                          size: "md",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                    },
                    {
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          align: "start",
                          text: "ขอบคุณภาพจาก: museumthailand",
                          contents: [],
                          color: "#5B5858FF",
                          type: "text",
                          size: "xs",
                        },
                      ],
                      type: "box",
                    },
                  ],
                  layout: "vertical",
                  type: "box",
                },
              ],
              action: {
                type: "message",
                label: "ศาลหลักเมือง",
                text: "ศาลหลักเมือง",
              },
              type: "box",
            },
            footer: {
              contents: [
                {
                  margin: "xl",
                  type: "separator",
                  color: "#696969FF",
                },
                {
                  action: {
                    text: "รายละเอียดศาลหลักเมือง",
                    label: "รายละเอียด",
                    type: "message",
                  },
                  type: "button",
                  color: "#FEFEFEFF",
                  height: "sm",
                  gravity: "bottom",
                  style: "secondary",
                },
                {
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  type: "button",
                  height: "sm",
                  style: "secondary",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการศาลหลักเมือง",
                  },
                },
                {
                  action: {
                    type: "message",
                    text: "เส้นทางไปศาลหลักเมือง",
                    label: "แผนที่",
                  },
                  style: "secondary",
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  type: "button",
                },
                {
                  height: "sm",
                  action: {
                    text: "ค่าเข้าศาลหลักเมือง",
                    label: "ค่าเข้าชม",
                    type: "message",
                  },
                  gravity: "bottom",
                  type: "button",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              spacing: "sm",
              layout: "vertical",
              type: "box",
            },
            hero: {
              size: "full",
              aspectMode: "cover",
              url: "https://www.museumthailand.com/upload/evidence/1498641221_54801.jpg",
              action: {
                uri: "https://linecorp.com/",
                type: "uri",
                label: "Line",
              },
              type: "image",
              aspectRatio: "20:13",
            },
            direction: "ltr",
            type: "bubble",
          },
          {
            direction: "ltr",
            footer: {
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  style: "secondary",
                  action: {
                    text: "รายละเอียดพระธาตุขามแก่น",
                    label: "รายละเอียด",
                    type: "message",
                  },
                  color: "#FEFEFEFF",
                  type: "button",
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  action: {
                    text: "เวลาทำการพระธาตุขามแก่น",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                  gravity: "bottom",
                  height: "sm",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  type: "button",
                },
                {
                  gravity: "bottom",
                  style: "secondary",
                  type: "button",
                  color: "#FFFFFFFF",
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปพระธาตุขามแก่น",
                    type: "message",
                  },
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  height: "sm",
                  type: "button",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    text: "ค่าเข้าพระธาตุขามแก่น",
                    type: "message",
                    label: "ค่าเข้าชม",
                  },
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              type: "box",
            },
            type: "bubble",
            body: {
              action: {
                type: "message",
                text: "พระธาตุขามแก่น",
                label: "พระธาตุขามแก่น",
              },
              type: "box",
              layout: "vertical",
              contents: [
                {
                  size: "xl",
                  color: "#000000FF",
                  text: "พระธาตุขามแก่น",
                  weight: "bold",
                  align: "start",
                  type: "text",
                  contents: [],
                },
                {
                  layout: "vertical",
                  contents: [
                    {
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                          size: "md",
                          text: "ประเภท : วัด",
                        },
                      ],
                      spacing: "sm",
                      type: "box",
                      layout: "baseline",
                    },
                    {
                      spacing: "sm",
                      contents: [
                        {
                          type: "text",
                          text: "ขอบคุณภาพจาก: เว็บไซต์ khonkaenlink",
                          size: "xs",
                          align: "start",
                          contents: [],
                          color: "#5B5858FF",
                        },
                      ],
                      layout: "baseline",
                      type: "box",
                    },
                  ],
                  margin: "lg",
                  spacing: "sm",
                  type: "box",
                },
              ],
            },
            hero: {
              url: "https://old.khonkaenlink.info/home/upload/photo/news/7Sin5Hxg.jpg",
              type: "image",
              aspectRatio: "20:13",
              aspectMode: "cover",
              size: "full",
              action: {
                label: "Line",
                type: "uri",
                uri: "https://linecorp.com/",
              },
            },
          },
          {
            body: {
              layout: "vertical",
              type: "box",
              action: {
                text: "วัดทุ่งเศรษฐี",
                label: "วัดทุ่งเศรษฐี",
                type: "message",
              },
              contents: [
                {
                  weight: "bold",
                  type: "text",
                  align: "start",
                  color: "#000000FF",
                  size: "xl",
                  text: "วัดทุ่งเศรษฐี",
                  contents: [],
                },
                {
                  spacing: "sm",
                  type: "box",
                  contents: [
                    {
                      spacing: "sm",
                      type: "box",
                      layout: "baseline",
                      contents: [
                        {
                          text: "ประเภท : วัด",
                          color: "#5B5858FF",
                          type: "text",
                          size: "md",
                          contents: [],
                        },
                      ],
                    },
                    {
                      layout: "baseline",
                      spacing: "sm",
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: thailandtourismdirectory",
                          type: "text",
                          size: "xs",
                          contents: [],
                          color: "#5B5858FF",
                          align: "start",
                        },
                      ],
                      type: "box",
                    },
                  ],
                  layout: "vertical",
                  margin: "lg",
                },
              ],
            },
            hero: {
              url: "https://files.thailandtourismdirectory.go.th/assets/upload/2018/01/15/201801159d30b01afa014de703891cc6eaf40e2e154734.jpg",
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              aspectMode: "cover",
              type: "image",
              aspectRatio: "20:13",
              size: "full",
            },
            type: "bubble",
            footer: {
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  color: "#FEFEFEFF",
                  style: "secondary",
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    type: "message",
                    text: "รายละเอียดวัดทุ่งเศรษฐี",
                    label: "รายละเอียด",
                  },
                },
                {
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการวัดทุ่งเศรษฐี",
                  },
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  type: "button",
                  style: "secondary",
                },
                {
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปวัดทุ่งเศรษฐี",
                  },
                  type: "button",
                  gravity: "bottom",
                  height: "sm",
                },
                {
                  action: {
                    label: "ค่าเข้าชม",
                    type: "message",
                    text: "ค่าเข้าวัดทุ่งเศรษฐี",
                  },
                  type: "button",
                  gravity: "bottom",
                  height: "sm",
                  color: "#FFFFFFFF",
                  style: "secondary",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              type: "box",
              layout: "vertical",
              spacing: "sm",
            },
            direction: "ltr",
          },
          {
            direction: "ltr",
            body: {
              layout: "vertical",
              type: "box",
              contents: [
                {
                  type: "text",
                  color: "#000000FF",
                  text: "วัดถ้ำแสงธรรม",
                  size: "xl",
                  weight: "bold",
                  contents: [],
                  align: "start",
                },
                {
                  layout: "vertical",
                  margin: "lg",
                  spacing: "sm",
                  contents: [
                    {
                      contents: [
                        {
                          size: "md",
                          contents: [],
                          text: "ประเภท : วัด",
                          color: "#5B5858FF",
                          type: "text",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                      type: "box",
                    },
                    {
                      contents: [
                        {
                          size: "xs",
                          align: "start",
                          color: "#5B5858FF",
                          type: "text",
                          text: "ขอบคุณภาพจาก : องค์การบริหารส่วนตำบลบริบูรณ์",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                      type: "box",
                      layout: "baseline",
                    },
                  ],
                  type: "box",
                },
              ],
              action: {
                label: "วัดถ้ำแสงธรรม",
                text: "วัดถ้ำแสงธรรม",
                type: "message",
              },
            },
            type: "bubble",
            footer: {
              type: "box",
              spacing: "sm",
              layout: "vertical",
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  style: "secondary",
                  gravity: "bottom",
                  height: "sm",
                  action: {
                    text: "รายละเอียดวัดถ้ำแสงธรรม",
                    label: "รายละเอียด",
                    type: "message",
                  },
                  type: "button",
                  color: "#FEFEFEFF",
                },
                {
                  action: {
                    type: "message",
                    text: "เวลาทำการวัดถ้ำแสงธรรม",
                    label: "เวลาทำการ",
                  },
                  height: "sm",
                  type: "button",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                },
                {
                  type: "button",
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปวัดถ้ำแสงธรรม",
                    type: "message",
                  },
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  height: "sm",
                },
                {
                  height: "sm",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  type: "button",
                  style: "secondary",
                  action: {
                    text: "ค่าเข้าวัดถ้ำแสงธรรม",
                    label: "ค่าเข้าชม",
                    type: "message",
                  },
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            hero: {
              action: {
                label: "Line",
                uri: "https://linecorp.com/",
                type: "uri",
              },
              url: "https://www.boriboon.go.th/docs/img/83caf9c0-e091-11ec-8d9d-1ffa639e91b5_webp_original.jpg",
              type: "image",
              aspectMode: "cover",
              aspectRatio: "20:13",
              size: "full",
            },
          },
          {
            direction: "ltr",
            footer: {
              type: "box",
              layout: "vertical",
              spacing: "sm",
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  color: "#FEFEFEFF",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดวัดถ้ำผาเกิ้ง",
                    type: "message",
                  },
                  height: "sm",
                },
                {
                  type: "button",
                  action: {
                    type: "message",
                    text: "เวลาทำการวัดถ้ำผาเกิ้ง",
                    label: "เวลาทำการ",
                  },
                  style: "secondary",
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                },
                {
                  style: "secondary",
                  color: "#FFFFFFFF",
                  action: {
                    type: "message",
                    text: "เส้นทางไปวัดถ้ำผาเกิ้ง",
                    label: "แผนที่",
                  },
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                },
                {
                  action: {
                    text: "ค่าเข้าวัดถ้ำผาเกิ้ง",
                    label: "ค่าเข้าชม",
                    type: "message",
                  },
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            type: "bubble",
            body: {
              layout: "vertical",
              contents: [
                {
                  color: "#000000FF",
                  contents: [],
                  size: "xl",
                  text: "วัดถ้ำผาเกิ้ง",
                  align: "start",
                  type: "text",
                  weight: "bold",
                },
                {
                  margin: "lg",
                  type: "box",
                  layout: "vertical",
                  contents: [
                    {
                      contents: [
                        {
                          text: "ประเภท : วัด",
                          contents: [],
                          type: "text",
                          size: "md",
                          color: "#5B5858FF",
                        },
                      ],
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          contents: [],
                          align: "start",
                          size: "xs",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก:เว็บไซต์ Readme.me ",
                          type: "text",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                    },
                  ],
                  spacing: "sm",
                },
              ],
              action: {
                text: "วัดถ้ำผาเกิ้ง",
                type: "message",
                label: "วัดถ้ำผาเกิ้ง",
              },
              type: "box",
            },
            hero: {
              size: "full",
              aspectMode: "cover",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              aspectRatio: "20:13",
              type: "image",
              url: "https://th.readme.me/f/17169/5b126dff8c213d49ed3fb6ca.jpg",
            },
          },
          {
            type: "bubble",
            body: {
              layout: "vertical",
              action: {
                label: "วัดป่าแสงอรุณ",
                type: "message",
                text: "วัดป่าแสงอรุณ",
              },
              type: "box",
              contents: [
                {
                  contents: [],
                  color: "#000000FF",
                  size: "xl",
                  weight: "bold",
                  type: "text",
                  text: "วัดป่าแสงอรุณ",
                  align: "start",
                },
                {
                  contents: [
                    {
                      type: "box",
                      layout: "baseline",
                      contents: [
                        {
                          size: "md",
                          text: "ประเภท : วัด",
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                        },
                      ],
                      spacing: "sm",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          align: "start",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก: ชีวิตนี้ต้องมี 1000 วัด",
                          type: "text",
                          size: "xs",
                          contents: [],
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                    },
                  ],
                  spacing: "sm",
                  margin: "lg",
                  layout: "vertical",
                  type: "box",
                },
              ],
            },
            footer: {
              type: "box",
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดวัดป่าแสงอรุณ",
                    type: "message",
                  },
                  type: "button",
                  style: "secondary",
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  height: "sm",
                  type: "button",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    text: "เวลาทำการวัดป่าแสงอรุณ",
                    type: "message",
                    label: "เวลาทำการ",
                  },
                },
                {
                  height: "sm",
                  type: "button",
                  action: {
                    type: "message",
                    text: "เส้นทางไปวัดป่าแสงอรุณ",
                    label: "แผนที่",
                  },
                  gravity: "bottom",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  style: "secondary",
                  height: "sm",
                  action: {
                    type: "message",
                    text: "ค่าเข้าวัดป่าแสงอรุณ",
                    label: "ค่าเข้าชม",
                  },
                  type: "button",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              layout: "vertical",
              spacing: "sm",
            },
            hero: {
              type: "image",
              action: {
                type: "uri",
                uri: "https://linecorp.com/",
                label: "Line",
              },
              aspectRatio: "20:13",
              aspectMode: "cover",
              url: "https://t1.blockdit.com/photos/2023/03/64011c16263d5fed77a3e489_800x0xcover_5aVItd5A.jpg",
              size: "full",
            },
            direction: "ltr",
          },
          {
            hero: {
              aspectRatio: "20:13",
              action: {
                uri: "https://linecorp.com/",
                type: "uri",
                label: "Line",
              },
              type: "image",
              size: "full",
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/KaewChakkraphat1.jpg",
              aspectMode: "cover",
            },
            footer: {
              spacing: "sm",
              contents: [
                {
                  type: "separator",
                  color: "#696969FF",
                  margin: "xl",
                },
                {
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  type: "button",
                  color: "#FEFEFEFF",
                  action: {
                    label: "รายละเอียด",
                    type: "message",
                    text: "รายละเอียดวัดแก้วจักรพรรดิสิริสุทธาวาส",
                  },
                },
                {
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  color: "#FFFFFFFF",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการวัดแก้วจักรพรรดิสิริสุทธาวาส",
                  },
                  type: "button",
                },
                {
                  color: "#FFFFFFFF",
                  style: "secondary",
                  gravity: "bottom",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปวัดแก้วจักรพรรดิสิริสุทธาวาส",
                  },
                  height: "sm",
                  type: "button",
                },
                {
                  type: "button",
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าวัดแก้วจักรพรรดิสิริสุทธาวาส",
                    type: "message",
                  },
                  style: "secondary",
                  color: "#FFFFFFFF",
                  height: "sm",
                  gravity: "bottom",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
              type: "box",
              layout: "vertical",
            },
            direction: "ltr",
            body: {
              layout: "vertical",
              action: {
                text: "วัดแก้วจักรพรรดิสิริสุทธาวาส",
                label: "วัดแก้วจักรพรรดิสิริสุทธาวาส",
                type: "message",
              },
              contents: [
                {
                  weight: "bold",
                  align: "start",
                  color: "#000000FF",
                  size: "xl",
                  contents: [],
                  type: "text",
                  text: "วัดแก้วจักรพรรดิสิริสุทธาวาส",
                },
                {
                  type: "box",
                  spacing: "sm",
                  contents: [
                    {
                      spacing: "sm",
                      contents: [
                        {
                          contents: [],
                          text: "ประเภท : วัด",
                          color: "#5B5858FF",
                          type: "text",
                          size: "md",
                        },
                      ],
                      type: "box",
                      layout: "baseline",
                    },
                    {
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          color: "#5B5858FF",
                          contents: [],
                          type: "text",
                          align: "start",
                          text: "ขอบคุณภาพจาก: ประสมสุข เล็ก สงวนเงิน, เพจ ขอนแก่น-Khonkaen Station",
                          size: "xs",
                        },
                      ],
                    },
                  ],
                  margin: "lg",
                  layout: "vertical",
                },
              ],
              type: "box",
            },
            type: "bubble",
          },
          {
            footer: {
              layout: "vertical",
              type: "box",
              spacing: "sm",
              contents: [
                {
                  color: "#696969FF",
                  type: "separator",
                  margin: "xl",
                },
                {
                  style: "secondary",
                  gravity: "bottom",
                  type: "button",
                  action: {
                    type: "message",
                    label: "รายละเอียด",
                    text: "รายละเอียดเทวาลัยศิวะมหาเทพ",
                  },
                  color: "#FEFEFEFF",
                  height: "sm",
                },
                {
                  type: "button",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เวลาทำการเทวาลัยศิวะมหาเทพ",
                    label: "เวลาทำการ",
                  },
                },
                {
                  height: "sm",
                  type: "button",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  action: {
                    type: "message",
                    text: "เส้นทางไปเทวาลัยศิวะมหาเทพ",
                    label: "แผนที่",
                  },
                  gravity: "bottom",
                },
                {
                  action: {
                    label: "ค่าเข้าชม",
                    text: "ค่าเข้าเทวาลัยศิวะมหาเทพ",
                    type: "message",
                  },
                  height: "sm",
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
            },
            type: "bubble",
            hero: {
              url: "https://raw.githubusercontent.com/ArreerakKlangindet/image-storage/main/image-detail/ShivaMahadev1.jpg",
              action: {
                type: "uri",
                label: "Line",
                uri: "https://linecorp.com/",
              },
              aspectMode: "cover",
              type: "image",
              size: "full",
              aspectRatio: "20:13",
            },
            body: {
              action: {
                text: "เทวาลัยศิวะมหาเทพ",
                label: "เทวาลัยศิวะมหาเทพ",
                type: "message",
              },
              type: "box",
              layout: "vertical",
              contents: [
                {
                  contents: [],
                  align: "start",
                  type: "text",
                  size: "xl",
                  color: "#000000FF",
                  text: "เทวาลัยศิวะมหาเทพ",
                  weight: "bold",
                },
                {
                  layout: "vertical",
                  type: "box",
                  spacing: "sm",
                  margin: "lg",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          contents: [],
                          color: "#5B5858FF",
                          size: "md",
                          text: "ประเภท : วัด",
                          type: "text",
                        },
                      ],
                    },
                    {
                      contents: [
                        {
                          size: "xs",
                          color: "#5B5858FF",
                          text: "ขอบคุณภาพจาก: เพจ เทวาลัยศิวะมหาเทพ ขอนแก่น",
                          contents: [],
                          type: "text",
                          align: "start",
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                      type: "box",
                    },
                  ],
                },
              ],
            },
            direction: "ltr",
          },
        ],
        type: "carousel",
      },
    },
    shopping: {
      altText: "แหล่งช็อปปิ้ง",
      contents: {
        contents: [
          {
            hero: {
              type: "image",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              aspectMode: "cover",
              aspectRatio: "20:13",
              url: "https://api.tourismthailand.org/upload/live/business_content_gallery/12636/P06002151_2.jpeg",
              size: "full",
            },
            type: "bubble",
            body: {
              action: {
                text: "ถนนคนเดินขอนแก่น",
                type: "message",
                label: "ถนนคนเดินขอนแก่น",
              },
              contents: [
                {
                  text: "ถนนคนเดินขอนแก่น",
                  size: "xl",
                  align: "start",
                  type: "text",
                  weight: "bold",
                  color: "#000000FF",
                  contents: [],
                },
                {
                  contents: [
                    {
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          contents: [],
                          color: "#5B5858FF",
                          text: "ประเภท : แหล่งช็อปปิ้ง",
                          size: "md",
                          type: "text",
                        },
                      ],
                      layout: "baseline",
                    },
                    {
                      type: "box",
                      contents: [
                        {
                          align: "start",
                          text: "ขอบคุณภาพจาก: tourismthailand",
                          type: "text",
                          size: "xs",
                          color: "#5B5858FF",
                          contents: [],
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                    },
                  ],
                  type: "box",
                  margin: "lg",
                  layout: "vertical",
                  spacing: "sm",
                },
              ],
              type: "box",
              layout: "vertical",
            },
            direction: "ltr",
            footer: {
              contents: [
                {
                  type: "separator",
                  color: "#696969FF",
                  margin: "xl",
                },
                {
                  height: "sm",
                  action: {
                    type: "message",
                    text: "รายละเอียดถนนคนเดินขอนแก่น",
                    label: "รายละเอียด",
                  },
                  color: "#FEFEFEFF",
                  style: "secondary",
                  type: "button",
                  gravity: "bottom",
                },
                {
                  gravity: "bottom",
                  type: "button",
                  style: "secondary",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการถนนคนเดินขอนแก่น",
                  },
                  color: "#FFFFFFFF",
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  style: "secondary",
                  height: "sm",
                  type: "button",
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปถนนคนเดินขอนแก่น",
                    type: "message",
                  },
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
              spacing: "sm",
              layout: "vertical",
            },
          },
          {
            hero: {
              action: {
                type: "uri",
                label: "Line",
                uri: "https://linecorp.com/",
              },
              aspectMode: "cover",
              url: "https://api.tourismthailand.org/upload/live/business_content_main_image_mobile/12640/P06002152_1.jpeg",
              aspectRatio: "20:13",
              type: "image",
              size: "full",
            },
            footer: {
              spacing: "sm",
              contents: [
                {
                  type: "separator",
                  color: "#696969FF",
                  margin: "xl",
                },
                {
                  type: "button",
                  gravity: "bottom",
                  action: {
                    text: "รายละเอียดตลาดต้นตาล",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  style: "secondary",
                  color: "#FEFEFEFF",
                  height: "sm",
                },
                {
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                  action: {
                    type: "message",
                    text: "เวลาทำการตลาดต้นตาล",
                    label: "เวลาทำการ",
                  },
                  height: "sm",
                  type: "button",
                  style: "secondary",
                },
                {
                  action: {
                    label: "แผนที่",
                    text: "เส้นทางไปตลาดต้นตาล",
                    type: "message",
                  },
                  height: "sm",
                  style: "secondary",
                  type: "button",
                  gravity: "bottom",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              layout: "vertical",
              type: "box",
            },
            body: {
              contents: [
                {
                  align: "start",
                  size: "xl",
                  type: "text",
                  contents: [],
                  text: "ตลาดต้นตาล",
                  weight: "bold",
                  color: "#000000FF",
                },
                {
                  type: "box",
                  contents: [
                    {
                      type: "box",
                      contents: [
                        {
                          type: "text",
                          text: "ประเภท : แหล่งช็อปปิ้ง",
                          size: "md",
                          color: "#5B5858FF",
                          contents: [],
                        },
                      ],
                      layout: "baseline",
                      spacing: "sm",
                    },
                    {
                      contents: [
                        {
                          text: "ขอบคุณภาพจาก: tourismthailand",
                          color: "#5B5858FF",
                          type: "text",
                          contents: [],
                          align: "start",
                          size: "xs",
                        },
                      ],
                      spacing: "sm",
                      layout: "baseline",
                      type: "box",
                    },
                  ],
                  spacing: "sm",
                  layout: "vertical",
                  margin: "lg",
                },
              ],
              layout: "vertical",
              type: "box",
              action: {
                text: "ตลาดต้นตาล",
                type: "message",
                label: "ตลาดต้นตาล",
              },
            },
            type: "bubble",
            direction: "ltr",
          },
          {
            body: {
              layout: "vertical",
              contents: [
                {
                  align: "start",
                  contents: [],
                  type: "text",
                  color: "#000000FF",
                  text: "เปิดท้ายหอกาญ",
                  size: "xl",
                  weight: "bold",
                },
                {
                  layout: "vertical",
                  spacing: "sm",
                  margin: "lg",
                  type: "box",
                  contents: [
                    {
                      contents: [
                        {
                          size: "md",
                          color: "#5B5858FF",
                          text: "ประเภท : แหล่งช็อปปิ้ง",
                          contents: [],
                          type: "text",
                        },
                      ],
                      layout: "baseline",
                      type: "box",
                      spacing: "sm",
                    },
                    {
                      layout: "baseline",
                      spacing: "sm",
                      contents: [
                        {
                          color: "#5B5858FF",
                          type: "text",
                          text: "ขอบคุณภาพจาก: เพจ เปิดท้ายหอกาญ มข.",
                          align: "start",
                          contents: [],
                          size: "xs",
                        },
                      ],
                      type: "box",
                    },
                  ],
                },
              ],
              action: {
                type: "message",
                text: "เปิดท้ายหอกาญ",
                label: "เปิดท้ายหอกาญ",
              },
              type: "box",
            },
            type: "bubble",
            hero: {
              aspectMode: "cover",
              size: "full",
              aspectRatio: "20:13",
              url: "https://img.wongnai.com/p/1920x0/2019/05/07/f34a58eaccbd4aadb64c5e0ece6f4e7e.jpg",
              type: "image",
              action: {
                uri: "https://linecorp.com/",
                type: "uri",
                label: "Line",
              },
            },
            direction: "ltr",
            footer: {
              spacing: "sm",
              contents: [
                {
                  margin: "xl",
                  color: "#696969FF",
                  type: "separator",
                },
                {
                  type: "button",
                  height: "sm",
                  style: "secondary",
                  action: {
                    label: "รายละเอียด",
                    text: "รายละเอียดเปิดท้ายหอกาญ",
                    type: "message",
                  },
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                },
                {
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  type: "button",
                  style: "secondary",
                  action: {
                    label: "เวลาทำการ",
                    type: "message",
                    text: "เวลาทำการเปิดท้ายหอกาญ",
                  },
                },
                {
                  height: "sm",
                  color: "#FFFFFFFF",
                  gravity: "bottom",
                  action: {
                    text: "เส้นทางไปเปิดท้ายหอกาญ",
                    label: "แผนที่",
                    type: "message",
                  },
                  style: "secondary",
                  type: "button",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              layout: "vertical",
              type: "box",
            },
          },
          {
            body: {
              contents: [
                {
                  color: "#000000FF",
                  weight: "bold",
                  align: "start",
                  contents: [],
                  text: "เซ็นทรัลขอนแก่น",
                  type: "text",
                  size: "xl",
                },
                {
                  contents: [
                    {
                      spacing: "sm",
                      layout: "baseline",
                      contents: [
                        {
                          contents: [],
                          type: "text",
                          size: "md",
                          color: "#5B5858FF",
                          text: "ประเภท : แหล่งช็อปปิ้ง",
                        },
                      ],
                      type: "box",
                    },
                    {
                      spacing: "sm",
                      type: "box",
                      contents: [
                        {
                          contents: [],
                          align: "start",
                          color: "#5B5858FF",
                          type: "text",
                          text: "ขอบคุณภาพจาก: thaimiceconnect",
                          size: "xs",
                        },
                      ],
                      layout: "baseline",
                    },
                  ],
                  margin: "lg",
                  type: "box",
                  layout: "vertical",
                  spacing: "sm",
                },
              ],
              layout: "vertical",
              action: {
                label: "เซ็นทรัลขอนแก่น",
                text: "เซ็นทรัลขอนแก่น",
                type: "message",
              },
              type: "box",
            },
            direction: "ltr",
            footer: {
              spacing: "sm",
              layout: "vertical",
              type: "box",
              contents: [
                {
                  margin: "xl",
                  color: "#696969FF",
                  type: "separator",
                },
                {
                  type: "button",
                  gravity: "bottom",
                  height: "sm",
                  style: "secondary",
                  color: "#FEFEFEFF",
                  action: {
                    type: "message",
                    label: "รายละเอียด",
                    text: "รายละเอียดเซ็นทรัลขอนแก่น",
                  },
                },
                {
                  height: "sm",
                  color: "#FFFFFFFF",
                  type: "button",
                  action: {
                    text: "เวลาทำการเซ็นทรัลขอนแก่น",
                    label: "เวลาทำการ",
                    type: "message",
                  },
                  style: "secondary",
                  gravity: "bottom",
                },
                {
                  color: "#FFFFFFFF",
                  type: "button",
                  height: "sm",
                  gravity: "bottom",
                  action: {
                    label: "แผนที่",
                    type: "message",
                    text: "เส้นทางไปเซ็นทรัลขอนแก่น",
                  },
                  style: "secondary",
                },
                {
                  type: "spacer",
                  size: "sm",
                },
              ],
            },
            type: "bubble",
            hero: {
              url: "https://www.thaimiceconnect.com/images/upload/business/2859/10859/1508478299_151765194522.jpg",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              aspectRatio: "20:13",
              type: "image",
              aspectMode: "cover",
              size: "full",
            },
          },
          {
            footer: {
              contents: [
                {
                  type: "separator",
                  margin: "xl",
                  color: "#696969FF",
                },
                {
                  style: "secondary",
                  height: "sm",
                  gravity: "bottom",
                  color: "#FEFEFEFF",
                  action: {
                    text: "รายละเอียดแฟรี่พลาซ่า",
                    type: "message",
                    label: "รายละเอียด",
                  },
                  type: "button",
                },
                {
                  height: "sm",
                  action: {
                    type: "message",
                    label: "เวลาทำการ",
                    text: "เวลาทำการแฟรี่พลาซ่า",
                  },
                  type: "button",
                  gravity: "bottom",
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  gravity: "bottom",
                  height: "sm",
                  type: "button",
                  action: {
                    type: "message",
                    label: "แผนที่",
                    text: "เส้นทางไปแฟรี่พลาซ่า",
                  },
                  style: "secondary",
                  color: "#FFFFFFFF",
                },
                {
                  size: "sm",
                  type: "spacer",
                },
              ],
              type: "box",
              spacing: "sm",
              layout: "vertical",
            },
            body: {
              action: {
                type: "message",
                label: "แฟรี่พลาซ่า",
                text: "แฟรี่พลาซ่า",
              },
              contents: [
                {
                  size: "xl",
                  text: "แฟรี่พลาซ่า",
                  type: "text",
                  weight: "bold",
                  align: "start",
                  color: "#000000FF",
                  contents: [],
                },
                {
                  type: "box",
                  layout: "vertical",
                  spacing: "sm",
                  contents: [
                    {
                      type: "box",
                      spacing: "sm",
                      contents: [
                        {
                          type: "text",
                          contents: [],
                          color: "#5B5858FF",
                          text: "ประเภท : แหล่งช็อปปิ้ง",
                          size: "md",
                        },
                      ],
                      layout: "baseline",
                    },
                    {
                      layout: "baseline",
                      type: "box",
                      contents: [
                        {
                          color: "#5B5858FF",
                          size: "xs",
                          type: "text",
                          align: "start",
                          text: "ขอบคุณภาพจาก: เพจ สถานีขอนแก่น : รีวิวคาเฟ่ อาหาร สถานที่ท่องเที่ยว",
                          contents: [],
                        },
                      ],
                      spacing: "sm",
                    },
                  ],
                  margin: "lg",
                },
              ],
              type: "box",
              layout: "vertical",
            },
            hero: {
              aspectRatio: "20:13",
              action: {
                uri: "https://linecorp.com/",
                label: "Line",
                type: "uri",
              },
              type: "image",
              aspectMode: "cover",
              url: "https://lh5.googleusercontent.com/p/AF1QipNswfomyX2ljEuln0cEPXRBJ79vBWOg3RvZ7w1p=w1080-k-no",
              size: "full",
            },
            direction: "ltr",
            type: "bubble",
          },
        ],
        type: "carousel",
      },
      type: "flex",
    },
  };
  if (questionText.includes("ภูเขา") && flexMessages.mountain) {
    agent.add(
      new Payload(agent.LINE, flexMessages.mountain, { sendAsMessage: true })
    );
  } else if (questionText.includes("สวนสัตว์")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.zoo, { sendAsMessage: true })
    );
  } else if (questionText.includes("อุทยานแห่งชาติ")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.national, { sendAsMessage: true })
    );
  } else if (questionText.includes("พิพิธภัณฑ์")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.museum, { sendAsMessage: true })
    );
  } else if (questionText.includes("สวนน้ำ")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.water, { sendAsMessage: true })
    );
  } else if (questionText.includes("สวนสาธารณะ")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.park, { sendAsMessage: true })
    );
  } else if (questionText.includes("วัด")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.temple, { sendAsMessage: true })
    );
  } else if (questionText.includes("ช็อปปิ้ง")) {
    agent.add(
      new Payload(agent.LINE, flexMessages.shopping, { sendAsMessage: true })
    );
  } else {
    console.warn("No matching location found for:", questionText);
    agent.add("ขออภัย ไม่พบข้อมูลสถานที่นี้");
  }
};

module.exports = sendTouristFlexMessage;
