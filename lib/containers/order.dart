import 'package:dynamic_theme/helpers/colors.dart';
import 'package:dynamic_theme/helpers/custom_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'order',
        transitionBetweenRoutes: false,
        middle: Text(AppLocalizations.of(context)!.order),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 44.0,
        ),
        child: ScrollConfiguration(
          behavior: CustomBehavior(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: ColorTheme.of(context).colorF3F3F6,
                  height: 160.0,
                  child: Center(
                      child: Text(
                    '广告位',
                    style: Theme.of(context).textTheme.headline4,
                  )),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => const OrderCard(),
                  childCount: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: EdgeInsets.only(bottom: 18.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: ColorTheme.of(context).borderColor.withOpacity(0.6),
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: ColorTheme.of(context).colorF3F3F6,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 24.0,
                    margin: EdgeInsets.only(left: 10.0),
                    color: ColorTheme.of(context).colorF3F3F6,
                  ),
                ],
              ),
              Container(
                width: 60.0,
                height: 20.0,
                margin: EdgeInsets.only(left: 10.0),
                color: ColorTheme.of(context).colorF3F3F6,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: ColorTheme.of(context).colorF3F3F6,
                ),
              ),
              SizedBox(
                height: 60.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      height: 16.0,
                      margin: EdgeInsets.only(left: 10.0),
                      color: ColorTheme.of(context).colorF3F3F6,
                    ),
                    Container(
                      width: 100.0,
                      height: 16.0,
                      margin: EdgeInsets.only(left: 10.0),
                      color: ColorTheme.of(context).colorF3F3F6,
                    ),
                    Container(
                      width: 60.0,
                      height: 16.0,
                      margin: EdgeInsets.only(left: 10.0),
                      color: ColorTheme.of(context).colorF3F3F6,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 60.0,
                height: 24.0,
                color: ColorTheme.of(context).colorF3F3F6,
              ),
              Container(
                width: 60.0,
                height: 24.0,
                margin: EdgeInsets.only(left: 10.0),
                color: ColorTheme.of(context).colorF3F3F6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
