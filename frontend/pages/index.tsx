"use client";
import {
  SismoConnectButton,
  AuthType,
  SismoConnectResponse,
  ClaimType,
} from "@sismo-core/sismo-connect-react";

// import { ConnectButton } from '@rainbow-me/rainbowkit';
import type { NextPage } from 'next';
import Head from 'next/head';
import styles from '../styles/Home.module.css';

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>RainbowKit App</title>
        <meta
          content="Generated by @rainbow-me/create-rainbowkit"
          name="description"
        />
        <link href="/favicon.ico" rel="icon" />
      </Head>

      <main className={styles.main}>
        {/* <ConnectButton /> */}

        <h1 className={styles.title}>
          Welcome to <a href="">Bond</a>
        </h1>

        <p className={styles.description}>
          BOND is a safe and secure wallet solution for crypto users. As there is an increasing adoption of cryptocurrencies around the world, losing private keys has remained a major issue. BOND is here to catalyze blockchain adoption by creating secure smart contacts that manage your wallet.{' '}
        </p>

        <SismoConnectButton
          config={{
            appId: "0xf5831918dad952c25dc4b8b45ee1d45f", // replace with your appId
            // vault: {
            //   // For development purposes insert the Data Sources that you want to impersonate here
            //   // Never use this in production
            //   impersonate: [
            //     // EVM
            //     "leo21.sismo.eth",
            //     "0xA4C94A6091545e40fc9c3E0982AEc8942E282F38",
            //     "0x1b9424ed517f7700e7368e34a9743295a225d889",
            //     "0x82fbed074f62386ed43bb816f748e8817bf46ff7",
            //     "0xc281bd4db5bf94f02a8525dca954db3895685700",
            //     // Github
            //     "github:leo21",
            //     // Twitter
            //     "twitter:leo21_eth",
            //     // Telegram
            //     "telegram:leo21",
            //   ],
            // },
            // displayRawResponse: true,
          }}
          // request proof of Data Sources ownership (e.g EVM, GitHub, twitter or telegram)
          auths={[{ authType: AuthType.GITHUB }]}
          // request zk proof that Data Source are part of a group
          // (e.g NFT ownership, Dao Participation, GitHub commits)
          claims={[
            // ENS Owners
            { groupId: "0x0f800ff28a426924cbe66b67b9f837e2" }, 
          ]} 
          // request message signature from users.
          signature={{ message: "I am verifying with Github with Privacy." }}
          // retrieve the Sismo Connect Reponse from the user's Sismo data vault
          onResponse={async (response: SismoConnectResponse) => {
            const res = await fetch("/api/verify", {
              method: "POST",
              body: JSON.stringify(response),
            });
            console.log(await res.json());
          }}
          // reponse in bytes to call a contract
          // onResponseBytes={async (response: string) => {
          //   console.log(response);
          // }}
        />
      </main>

      <footer className={styles.footer}>
        <a href="https://rainbow.me" rel="noopener noreferrer" target="_blank">
          Made with ❤️ by your frens at EthOnline 2023
        </a>
      </footer>
    </div>
  );
};

export default Home;
