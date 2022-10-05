import {
  IonContent,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonMenu,
  IonMenuToggle,
  IonNote,
} from '@ionic/react';

import React from 'react';
import { useLocation } from 'react-router-dom';
import { archiveOutline, archiveSharp, bluetoothOutline, bluetoothSharp, cloudOutline, cloudSharp, bookmarkOutline, heartOutline, heartSharp, mailOutline, mailSharp, paperPlaneOutline, paperPlaneSharp, trashOutline, trashSharp, warningOutline, warningSharp, pulseOutline, pulseSharp } from 'ionicons/icons';
import './Menu.css';

interface AppPage {
  url: string;
  iosIcon: string;
  mdIcon: string;
  title: string;
}

const appPages: AppPage[] = [
  {
    title: 'Connect Device',
    url: '/page/Send',
    iosIcon: bluetoothOutline,
    mdIcon: bluetoothSharp
  },
  {
    title: 'Recording',
    url: '/page/Recording',
    iosIcon: pulseOutline,
    mdIcon: pulseSharp
  },
  {
    title: 'Storage',
    url: '/page/Storage',
    iosIcon: cloudOutline,
    mdIcon: cloudSharp
  },
  {
    title: 'Send File',
    url: '/page/Send',
    iosIcon: paperPlaneOutline,
    mdIcon: paperPlaneSharp
  }
];

const labels = ['Family', 'Friends', 'Notes', 'Work', 'Travel', 'Reminders'];

const Menu: React.FC = () => {
  const location = useLocation();

  return (
    <IonMenu contentId="main" type="overlay">
      <IonContent>
        <IonList id="inbox-list">
          <IonListHeader>The Bond Project</IonListHeader>
          <IonNote>jlm0a3@uark.edu</IonNote>
          {appPages.map((appPage, index) => {
            return (
              <IonMenuToggle key={index} autoHide={false}>
                <IonItem className={location.pathname === appPage.url ? 'selected' : ''} routerLink={appPage.url} routerDirection="none" lines="none" detail={false}>
                  <IonIcon slot="start" ios={appPage.iosIcon} md={appPage.mdIcon} />
                  <IonLabel>{appPage.title}</IonLabel>
                </IonItem>
              </IonMenuToggle>
            );
          })}
        </IonList>
      </IonContent>
    </IonMenu>
  );
};

export default Menu;
