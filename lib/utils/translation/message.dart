import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'dashboard': 'Dashboard',
          'alert': "Are you sure?",
          'sure_alert': "Do you want to exit the App",
          "no_button": "No",
          "yes_button": "Yes",
          "username_empty_error": "Please Provide Username",
          "username_3_length_error":
              "Username should not be less than 3 characters",
          "username_10_length_error":
              "Username should not be more than 10 characters",
          "password_empty_error": "Please Provide Password",
          "password_3_length_error":
              "Password should not be less than 3 characters",
          "password_10_length_error":
              "Password should not be more than 10 characters",
          "sign_in_message": "Signing In...",
          "invalid_data": "Invalid username and password",
          "username_label": "UserName",
          "username_hint": "Enter UserName",
          "password_label": "Password",
          "password_hint": "Enter Password",
          "sign_in_button": "Sign In",
          "connectivity_issue": "You are not connected to Internet...",
          //common keys
          "message": "Message",
          "ok": "Ok",
          //home keys
          "logout": "Logout",
          "language_settings": "Language Settings",
          "select_language": "Select Language",
          "english": "English",
          "japanese": "Japanese",
          "rating": "Elo Rating",
          "tournaments": "Tournaments",
          "played": "Played",
          "won": "Won",
          "winning": "Winning",
          "percentage": "Percentage",
          "recommended_or_you": "Recommended For You",
          "no_data_found": "No data found..",
          "logout_message": "Do you want to logout"
        },
        'ja_JP': {
          'dashboard': 'ダッシュボード',
          'alert': "本気ですか?",
          'sure_alert': "アプリを終了しますか",
          "no_button": "番号",
          "yes_button": "はい",
          "username_empty_error": "ユーザー名を入力してください",
          "username_3_length_error": "ユーザー名は3文字以上にする必要があります",
          "username_10_length_error": "ユーザー名は10文字以内にする必要があります",
          "password_empty_error": "パスワードを入力してください",
          "password_3_length_error": "パスワードは3文字以上にする必要があります",
          "password_10_length_error": "パスワードは10文字以内にする必要があります",
          "sign_in_message": "サインイン...",
          "invalid_data": "無効なユーザー名とパスワード",
          "username_label": "ユーザー名",
          "username_hint": "ユーザーネームを入力してください",
          "password_label": "パスワード",
          "password_hint": "パスワードを入力する",
          "sign_in_button": "サインイン",
          "connectivity_issue": "インターネットに接続していません...",
          "message": "メッセージ",
          "ok": "OK",
          //home keys
          "logout": "ログアウト",
          "language_settings": "言語設定",
          "select_language": "言語を選択する",
          "english": "英語",
          "japanese": "日本人",
          "rating": "イロレーティング",
          "tournaments": "トーナメント",
          "played": "プレイした",
          "won": "勝った",
          "winning": "勝つ",
          "percentage": "パーセンテージ",
          "recommended_or_you": "あなたにおすすめ",
          "no_data_found": "何もデータが見つかりませんでした..",
          "logout_message": "ログアウトしますか"
        }
      };
}
