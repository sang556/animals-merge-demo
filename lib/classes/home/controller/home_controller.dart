import 'dart:ui';

import 'package:animalmerge/classes/home/model/home_model.dart';
import 'package:animalmerge/classes/home/view/home_column_view.dart';
import 'package:flutter/material.dart';

class HomeController extends StatefulWidget {
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: HomeColumnView(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    HomeCoreModel.addItem(1);
                  },
                  color: Colors.blue,
                  child: Text("Add"),
                ),
                SizedBox(
                  width: 30,
                ),
                DragTarget(
                  onWillAccept: (data) {
                    // print("data = $data onWillAccept --- 0");
                    return data != null;
                  },
                  onAccept: (data) {
                    HomeCoreModel.removeItem(data as HomeItem);
                  },
                  onLeave: (data) {
                    // print("data = $data onLeave --- 0");
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 100,
                      color: Colors.blue,
                      child: Text("remove"),
                    );
                  },
                )
              ],
            ),
          ),
          //棋盘
          Container(
            child: Center(
              child: CustomPaint(
                size: Size(300, 300),
                painter: MyPainter(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 30;
    double eHeight = size.height / 30;
    //画棋盘背景
    var paint = Paint()
      //是否启动抗锯齿
      ..isAntiAlias = true
      //绘画风格，默认为填充，有fill和stroke两种
      ..style = PaintingStyle.fill
      //颜色混合模式
      ..blendMode = BlendMode.exclusion
      //颜色渲染模式
      ..colorFilter = ColorFilter.mode(Colors.blueAccent, BlendMode.exclusion)
      //模糊遮罩效果
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0)
      //颜色渲染模式的质量
      ..filterQuality = FilterQuality.high
      //画笔笔触类型
      //round-画笔笔触呈半圆形轮廓开始和结束
      //butt-笔触开始和结束边缘平坦，没有外延
      //square-笔触开始和结束边缘平坦，向外延伸长度为画笔宽度的一半
      ..strokeCap = StrokeCap.round
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xFF888888)
      //画笔的宽度
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 30; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= 30; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    //绘制点
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.blue
    //画笔的宽度
      ..strokeWidth = 12.0;
    List<Offset> points = [
      Offset(0, 0),
      Offset(30, 50),
      Offset(20, 80),
      Offset(100, 40),
      Offset(150, 90),
      Offset(60, 110),
      Offset(260, 160)
    ];
    //PointMode是一个枚举类：points-绘制点 lines-绘制点，且数组内隔点相连，如1-2相连，3-4相连。如最后只剩下一个点，则不去绘制该点 polygon-数组内相邻点连接
    canvas.drawPoints(PointMode.points, points, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
