#ifndef METHOD_H
#define METHOD_H

#include <QObject>
#include <QJSValue>
#include <functional>
#include "arguments.h" // Arguments, Argument

class Method
    : public QObject
{
    Q_OBJECT

    QString         m_prototype;
    QString         m_name;
    QString         m_description;
    Arguments       m_args;
    std::function<void(const QJSValue&) > m_invoker;

public:
    Method(const QString &name_, const QString &description_, const Arguments& args_, const std::function<void(const QJSValue&) >& invoker_);

    Q_PROPERTY(QString         definitionType READ   getDefinitionType CONSTANT)

    Q_PROPERTY(QString         prototype      MEMBER m_prototype       CONSTANT)
    Q_PROPERTY(QString         name           MEMBER m_name            CONSTANT)
    Q_PROPERTY(QString         description    MEMBER m_description     CONSTANT)
    Q_PROPERTY(QList<QObject*> args           MEMBER m_args            CONSTANT)
    Q_INVOKABLE void           exec(const QJSValue& args);

protected:
    QString getDefinitionType() const { return "method"; }
};

#endif // METHOD_H
