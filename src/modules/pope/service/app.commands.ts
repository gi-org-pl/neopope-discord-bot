import { Context, SlashCommand, SlashCommandContext } from 'necord';
import { Injectable } from '@nestjs/common';

@Injectable()
export class AppCommands {
  @SlashCommand({
    name: 'pong',
    description: 'Ping-Pong Command',
  })
  public async onPing(@Context() [interaction]: SlashCommandContext) {
    return interaction.reply({ content: 'Ping!' });
  }
}
