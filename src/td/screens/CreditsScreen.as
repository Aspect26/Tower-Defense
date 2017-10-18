package td.screens {

import flash.events.Event;

import starling.text.TextField;
import starling.display.Sprite;

import td.Context;

import td.constants.Colors;
import td.constants.TextIds;
import td.ui.MenuTextButton;
import td.ui.TextButton;

public class CreditsScreen extends Sprite
    {
        private var backButton: TextButton;
        private var creditsText: String;
        private var introTextField: TextField;

        public function CreditsScreen()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(e: * = null) : void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            this.initialize();
            this.show();
        }

        private function initialize() : void {
            this.creditsText = 'Not implemented, yet!';

            introTextField = new TextField(200, 50, this.creditsText);
            introTextField.format.color = Colors.WHITE;

            backButton = new MenuTextButton(Context.text(TextIds.ButtonBack), onBack);
            backButton.x = 10;
            backButton.y = 50;
        }

        private function show() : void {
            this.addChild(introTextField);
            addChild(backButton);
        }

        private static function onBack() {
            Context.screenManager.showScreen(new MenuScreen());
        }

    }
}
