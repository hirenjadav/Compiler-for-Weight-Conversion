#include <bits/stdc++.h>
using namespace std;

int blankCheck(char ch)
{
    if (ch == '\n' || ch == '\t' || isspace(ch))
    {
        return 0;
    }
    return 1;
}

int letterCheck(char ch)
{
    if (ch >= 'a' && ch <= 'z' || ch >= 'A' && ch <= 'Z')
    {
        return 0;
    }
    return 1;
}

int digitCheck(char ch)
{
    if (ch >= '0' && ch <= '9')

    {
        return 0;
    }
    return 1;
}
int keywordCheck(string str)
{
    if (str.compare("kg") == 0 || str.compare("kilogram") == 0 || str.compare("kgs") == 0 ||
        str.compare("kilograms") == 0)
    {
        return 0;
    }
    else if (str.compare("grams") == 0 || str.compare("gram") == 0 || str.compare("gm") == 0 ||
             str.compare("gms") == 0)
    {
        return 0;
    }
    else if (str.compare("milligrams") == 0 || str.compare("milligram") == 0 || str.compare("mg") == 0 ||
             str.compare("mgs") == 0 || str.compare("much") == 0 || str.compare("many") == 0)
    {
        return 0;
    }
    else if (str.compare("equals") == 0 || str.compare("to") == 0 || str.compare("is") == 0 ||
             str.compare("how") == 0)
    {
        return 0;
    }
    return 1;
}

int main()
{
    string str = "";
    string fileName;

    int buffer = 0, state = 0;
    char ch;

    cout << "Enter file name : ";
    cin >> fileName;
    fstream file;
    file.open(fileName, ios::in);

    while (!file.eof())
    {
        if (buffer == 1)
        {
            buffer = 0;
        }
        else
        {
            file.get(ch);
        }
        switch (state)
        {
        case 0:
        {
            if (letterCheck(ch) == 0)
            {
                state = 1;
                str.push_back(ch);
            }
            else if (digitCheck(ch) == 0)
            {
                state = 2;
                str.push_back(ch);
            }
            else if (blankCheck(ch) == 0)
            {
                state = 0;
            }
            else if (ch == '?')
            {
                state = 9;
                str.push_back(ch);
            }
            else if (ch == '=')
            {
                state = 10;
                str.push_back(ch);
                break;
            }
            else
            {
                state = 7;
                str.push_back(ch);
            }
            break;
        }

        case 1:
        {
            if (letterCheck(ch) == 0)
            {
                state = 1;
                str.push_back(ch);
            }
            else
            {
                state = 3;
                buffer = 1;
            }
            break;
        }

        case 3:

        {
            if (keywordCheck(str) == 0)
            {
                cout << "keyword found : " << str << endl;
                str = "";
                buffer = 1;
                state = 0;
            }
            else
            {
                cout << "Error found : " << str << endl;
                str = "";
                buffer = 1;
                state = 0;
                break;
            }
            break;
        }

        case 2:
        {
            if (digitCheck(ch) == 0)
            {
                state = 2;
                str.push_back(ch);
            }
            else if (ch == '.')
            {
                state = 4;
                str.push_back(ch);
            }
            else
            {
                state = 8;
                buffer = 1;
            }
            break;
        }
        case 4:
        {
            if (digitCheck(ch) == 0)
            {
                state = 5;
                str.push_back(ch);
            }
            else
            {
                state = 7;
                buffer = 1;
            }
            break;
        }

        case 5:
        {
            if (digitCheck(ch) == 0)
            {
                state = 5;
                str.push_back(ch);
            }
            else
            {
                state = 6;
                buffer = 1;
            }
            break;
        }

        case 6:
        {
            cout << "Float Detected:" << str << endl;
            str = "";

            buffer = 1;
            state = 0;
            break;
        }
        case 7:
        {
            cout << "Error Found : " << str << endl;
            str = "";
            buffer = 1;
            state = 0;
            break;
        }
        case 8:
        {
            cout << "Integer Detected:" << str << endl;
            str = "";
            buffer = 0;
            state = 0;
            break;
        }
        case 9:
        {
            cout << "Question Mark Detected: " << str << endl;
            str = "";
            buffer = 0;
            state = 0;
            break;
        }
        case 10:
        {
            cout << "Equal to Detected: " << str << endl;
            str = "";
            buffer = 0;
            state = 0;
            break;
        }
        }
    }
    return 0;
}