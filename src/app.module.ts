import { Module } from '@nestjs/common';
import { StatusController } from 'src/modules/status/status.controller';
import { NecordModule } from 'necord';
import { IntentsBitField } from 'discord.js';
import { PopeModule } from './modules/pope/pope.module';

@Module({
  imports: [
    NecordModule.forRoot({
      token: process.env.DISCORD_TOKEN,
      intents: [IntentsBitField.Flags.Guilds],
      development: [process.env.DISCORD_GUID_ID],
    }),
    PopeModule,
  ],
  providers: [],
  controllers: [StatusController],
})
export class AppModule {}
