#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QVariant>
#include <QScreen>
#include <QDebug>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

   // registerNetworkTypes();
    //qRegisterMetaType<NetworkRequest>("NetworkRequest");
    QScreen* pscreen(app.primaryScreen());

    int  screen_width;
    int  screen_height;
    bool show_expanded(true);
    QString display_mode("FullScreen");

    show_expanded = false; // Uncomment for FULLSCREEN

    if(!show_expanded)
    {
        screen_width = pscreen->size().width();
        screen_height = pscreen->size().height();
    }
    else
    {
        screen_width = pscreen->availableGeometry().width();
        screen_height = pscreen->availableGeometry().height();
        display_mode = "Maximized";
    }
    int temp_width(screen_width);
    if(screen_height > screen_width)
    {
        screen_width = screen_height;
        screen_height = temp_width;
    }
    QQmlApplicationEngine* engine = new QQmlApplicationEngine(&app);
    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
