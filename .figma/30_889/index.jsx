import React from 'react';

import styles from './index.module.scss';

const Component = () => {
  return (
    <div className={styles.signIn}>
      <div className={styles.autoWrapper}>
        <img src="../image/mkwt28gr-mpsyek1.svg" className={styles.a1} />
        <div className={styles.frame900}>
          <p className={styles.time}>9:41</p>
          <img src="../image/mkwt28gr-csx9ca1.svg" className={styles.group2200} />
        </div>
        <div className={styles.logo}>
          <img src="../image/mkwt28gt-6vjgo1y.png" className={styles.a12} />
          <img src="../image/mkwt28gt-ake8xu2.png" className={styles.a2} />
        </div>
      </div>
      <div className={styles.authentication2}>
        <div className={styles.authentication}>
          <p className={styles.text3}>
            <span className={styles.text}>
              おかえり！
              <br />
            </span>
            <span className={styles.text2}>
              アプリ利用を続けるにはログインしてください。
            </span>
          </p>
          <div className={styles.frame2121457922}>
            <div className={styles.textField}>
              <div className={styles.frame2121457837}>
                <p className={styles.a}>メールアドレス</p>
              </div>
            </div>
            <div className={styles.frame2121457921}>
              <div className={styles.textField2}>
                <p className={styles.a3}>••••••••</p>
                <img
                  src="../image/mkwt28gr-kpxixzy.svg"
                  className={styles.linearSecurityEye}
                />
                <div className={styles.frame21214578372}>
                  <p className={styles.a}>パスワード</p>
                </div>
              </div>
              <p className={styles.text4}>パスワードをお忘れですか</p>
            </div>
            <div className={styles.confirmationOfTransf}>
              <div className={styles.checkBox} />
              <p className={styles.a4}>ログインしたままにする</p>
            </div>
          </div>
          <div className={styles.nextButton}>
            <p className={styles.label}>ログイン</p>
          </div>
        </div>
        <div className={styles.menu6}>
          <div className={styles.line} />
        </div>
      </div>
    </div>
  );
}

export default Component;
